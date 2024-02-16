import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/image_content.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/identifier.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/services/media_provider/manga/manga_formatter.dart';
import 'package:animo/services/media_provider/manga/manga_lut.dart';
import 'package:animo/utils/utils.dart';

part 'manga_provider.g.dart';

@riverpod
MangaProvider manga(MangaRef ref) {
  return MangaProvider(ref);
}

class MangaProvider extends MediaProvider<List<ImageContent>> {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.manga,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  MangaProvider(this._ref);

  @override
  Future<PaginatedData<MediaBasic>> explore(
    String path,
    Map<String, dynamic> options,
  ) async {
    if (path != 'filter') throw 'Unsupported path';

    return await filter(options);
  }

  @override
  Future<List<MediaBasic>> basicSearch(String query) async {
    final results = await filter({'query': query, 'limit': 5});
    return results.data;
  }

  @override
  Future<PaginatedData<MediaBasic>> filter(Map<String, dynamic> options) async {
    options.addAll({
      'q': options['query'],
      'type': 'comic',
      'tachiyomi': true,
      'limit': options['limit'] ?? 36,
    });
    options.remove('query');

    final response = await _dio.get<List<dynamic>>(
      '/v1.0/search',
      queryParameters: removeNulls(options),
    );

    return PaginatedData(
      haveMore: response.data!.length == options['limit'],
      data: response.data!.map(formatMangaFilter).toList(),
    );
  }

  @override
  Future<Media> getMedia(String slug) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/comic/$slug/?tachiyomi=true',
    );
    final comic = response.data!['comic'];

    String? native;
    final synonyms = (comic['md_titles'] as List<dynamic>).map((e) {
      if (e['lang'] == comic['iso639_1']) native = e['title'];

      return e['title'] as String;
    }).toList();
    final genres = (comic['md_comic_md_genres'] as List<dynamic>)
        .map(formatMangaGenre)
        .toList();
    final relations = comic['relate_from'] as List<dynamic>;
    String? al = comic['links']['al'];
    String? mal = comic['links']['mal'];

    return Media(
      slug: slug,
      id: comic['hid'],
      aniId: al == null ? null : int.tryParse(al),
      malId: mal == null ? null : int.tryParse(mal),
      title: comic['title'],
      native: native,
      synonyms: synonyms,
      cover: comic['cover_url'],
      type: MediaType.manga,
      format: genres.contains(SelectOption('Doujinshi', 'doujinshi'))
          ? MediaFormat.doujinshi
          : genres.contains(SelectOption('Oneshot', 'oneshot'))
              ? MediaFormat.oneShot
              : MediaFormat.manga,
      status: mangaStatus[comic['status']] ?? MediaStatus.unknown,
      description: comic['parsed'],
      year: comic['year'],
      genres: genres,
      rating: comic['bayesian_rating'] == null
          ? null
          : double.tryParse(comic['bayesian_rating']),
      relations: relations.isEmpty
          ? null
          : PaginatedData<BaseData>(
              haveMore: false,
              data: relations.map(formatMangaRelation).toList(),
            ),
      firstContent: formatMangaContent(response.data!['firstChap'], null),
      langList: List<String>.from(response.data!['langList']),
    );
  }

  @override
  Future<PaginatedData<MediaContent>> getMediaContents(
    Identifier identifier,
    Map<String, dynamic> options,
  ) async {
    final page = options['page'] ?? 1;

    options = {...options, 'chap': options['query'], 'limit': 100};
    options.remove('query');

    final response = await _dio.get<Map<String, dynamic>>(
      '/comic/${identifier.id}/chapters',
      queryParameters: options,
    );
    final data = response.data!;
    final total = data['total'];
    final contents = data['chapters'] as List;

    return PaginatedData(
      currentPage: page,
      total: total,
      haveMore: contents.length == options['limit'],
      data: contents.mapWithIndex(formatMangaContent).toList(),
    );
  }

  @override
  Future<ContentData<List<ImageContent>>> getContent(
    BaseData baseContent, {
    bool withContentList = false,
    int? current,
  }) async {
    final parent = await _ref.read(
      getMediaProvider(type: baseContent.type, slug: baseContent.parentSlug!)
          .future,
    );
    final syncData = parent.toSyncData();

    final response = await _dio.get<Map<String, dynamic>>(
      '/chapter/${baseContent.slug}?tachiyomi=true',
    );
    final data = response.data!;
    final contents = (current == null || withContentList)
        ? (data['chapters'] as List).mapWithIndex((formatMangaContent)).toList()
        : null;

    return ContentData(
      syncData: syncData,
      data: (data['chapter']['images'] as List)
          .map(
            (e) => ImageContent.fromMap(e),
          )
          .toList(),
      current: current ??
          contents!.indexWhere(
            (element) => element.slug == baseContent.slug,
          ),
      contents: contents,
    );
  }
}
