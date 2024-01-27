import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_provider.dart';
import 'package:animo/models/media_relation.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/services/formatter/manga.dart';
import 'package:animo/services/lut/manga.dart';
import 'package:animo/services/options/manga.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mangaProvider = Provider((ref) {
  return MangaProvider();
});

class MangaProvider extends MediaProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.manga,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  MangaProvider()
      : super(
          name: 'Manga',
          type: MediaType.manga,
          filterOptions: mangaOptions,
        );

  @override
  Future<List<MediaBasic>> basicSearch(String keyword) async {
    return await filter({'q': keyword});
  }

  @override
  Future<List<MediaBasic>> filter(
    Map<String, dynamic> options, {
    int page = 1,
  }) async {
    options.addAll({
      'type': 'comic',
      'tachiyomi': true,
      'limit': 36,
      'page': page,
    });

    final response = await _dio.get<List<dynamic>>(
      '/v1.0/search',
      queryParameters: formatQuery(options),
    );

    return response.data!.map(formatMangaFilter).toList();
  }

  @override
  Future<Media> getMedia(SyncData syncData) async {
    final response = await _dio
        .get<Map<String, dynamic>>('/comic/${syncData.slug}/?tachiyomi=true');
    final comic = response.data!['comic'];

    final titles = comic['md_titles'] as List<dynamic>;
    final genres = (comic['md_comic_md_genres'] as List<dynamic>)
        .map((e) => e['md_genres']['name'] as String)
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
      format: genres.contains('Doujinshi')
          ? MediaFormat.doujinshi
          : genres.contains('Oneshot')
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
      langList: List<String>.from(response.data!['langList']),
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseMedia media,
    int page,
  ) {
    // Not available from source
    throw UnimplementedError();
  }
}
