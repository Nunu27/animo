import 'package:animo/models/content/image_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/services/api.dart';
import 'package:animo/services/media_sources/manga/manga_formatter.dart';
import 'package:animo/services/media_sources/manga/manga_lut.dart';
import 'package:animo/services/media_sources/manga/manga_option.dart';

final mangaProvider = Provider((ref) {
  return MangaProvider(ref);
});

class MangaProvider extends MediaProvider<List<ImageContent>> {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.manga,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  MangaProvider(this._ref)
      : super(
          name: 'Manga',
          type: MediaType.manga,
          mediaQueryKey: 'q',
          mediaFilters: mangaMediaFilters,
          contentQueryKey: 'chap',
          contentFilters: mangaContentFilters,
        );

  @override
  Future<List<MediaBasic>> basicSearch(String query) async {
    final results = await filter({mediaQueryKey: query, 'limit': 5});
    return results.data;
  }

  @override
  Future<PaginatedData<MediaBasic>> filter(
    Map<String, dynamic> options, {
    int page = 1,
  }) async {
    options.addAll({
      'type': 'comic',
      'tachiyomi': true,
      'limit': options['limit'] ?? 36,
      'page': page,
    });

    final response = await _dio.get<List<dynamic>>(
      '/v1.0/search',
      queryParameters: formatQuery(options),
    );

    return PaginatedData(
      haveMore: false,
      data: response.data!.map(formatMangaFilter).toList(),
    );
  }

  @override
  Future<Media> getMedia(SyncData syncData) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/comic/${syncData.slug}/?tachiyomi=true',
    );
    final comic = response.data!['comic'];

    final titles = comic['md_titles'] as List<dynamic>;
    final genres = (comic['md_comic_md_genres'] as List<dynamic>)
        .map(formatMangaGenre)
        .toList();
    final relations = comic['relate_from'] as List<dynamic>;

    return Media(
      slug: syncData.slug,
      id: syncData.id,
      aniId: syncData.aniId,
      malId: syncData.malId,
      title: syncData.title,
      native: comic['lang_native'],
      synonyms: titles.map((e) => e['title']! as String).toList(),
      cover: syncData.cover,
      type: syncData.type,
      format: genres.contains(SelectOption('Doujinshi', 'doujinshi'))
          ? MediaFormat.doujinshi
          : genres.contains(SelectOption('Oneshot', 'oneshot'))
              ? MediaFormat.oneShot
              : MediaFormat.manga,
      status: mangaStatus[comic['status']] ?? MediaStatus.unknown,
      description: comic['desc'],
      year: comic['year'],
      genres: genres,
      rating: comic['bayesian_rating'] == null
          ? null
          : double.tryParse(comic['bayesian_rating']),
      relations: relations.isEmpty
          ? null
          : PaginatedData<MediaRelation>(
              haveMore: false,
              data: relations.map(formatMangaRelation).toList(),
            ),
      firstContent: formatMangaContent(response.data!['firstChap']),
      langList: List<String>.from(response.data!['langList']),
    );
  }

  @override
  Future<PaginatedData<MediaContent>> getMediaContents(
    SyncData syncData, {
    int page = 1,
    Map<String, dynamic>? options,
  }) async {
    options ??= {};

    options = {...options, 'page': page, 'limit': 100};

    final response = await _dio.get<Map<String, dynamic>>(
      '/comic/${syncData.id}/chapters',
      queryParameters: options,
    );
    final data = response.data!;
    final total = data['total'];
    final contents = data['chapters'] as List;

    return PaginatedData(
      currentPage: page,
      total: total,
      haveMore: page < total ~/ 100,
      data: contents.map(formatMangaContent).toList(),
    );
  }

  @override
  Future<ContentData<List<ImageContent>>> getContent(
    BaseData baseContent, {
    List<MediaContent>? contents,
  }) async {
    print(baseContent.slug);
    final parent = await _ref.read(getSyncDataProvider(baseContent).future);
    final response = await _dio.get<Map<String, dynamic>>(
      '/chapter/${baseContent.slug}?tachiyomi=true',
    );
    final data = response.data!;
    contents ??= (data['chapters'] as List).map((formatMangaContent)).toList();

    return ContentData(
      parent: parent,
      data: (data['chapter']['images'] as List)
          .map(
            (e) => ImageContent.fromMap(e),
          )
          .toList(),
      current: contents.indexWhere(
        (element) => element.slug == baseContent.slug,
      ),
      contents: contents,
    );
  }
}
