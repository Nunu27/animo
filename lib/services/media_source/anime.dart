import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_provider.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/services/formatter/anime.dart';
import 'package:animo/services/lut/anime.dart';
import 'package:animo/services/options/anime.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';

final animeProvider = Provider((ref) {
  return AnimeProvider();
});

class AnimeProvider extends MediaProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.anime,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  AnimeProvider()
      : super(
          name: 'Anime',
          type: MediaType.anime,
          filterOptions: animeOptions,
        );

  @override
  Future<List<MediaBasic>> basicSearch({required String keyword}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/ajax/search/suggest',
      queryParameters: {'keyword': keyword},
    );

    if (!response.data?['status']) return [];
    final document = parse(response.data?['html']);

    return document
        .getElementsByTagName('a')
        .where((element) => element.querySelector('.film-poster') != null)
        .map(formatAnimeBasicSearch)
        .toList();
  }

  @override
  Future<List<MediaBasic>> filter({
    String? keyword,
    String? type,
    String? status,
    String? season,
    String? sort,
    String? genres,
    int page = 1,
  }) async {
    final response = await _dio.get<String>(
      keyword == null ? '/filter' : '/search',
      queryParameters: formatQuery(
        {
          'keyword': keyword,
          'type': type,
          'status': status,
          'season': season,
          'sort': sort,
          'genres': genres,
          'page': page,
        },
      ),
    );

    final document = parse(response.data);

    return document
        .querySelectorAll('.flw-item')
        .map(formatAnimeSearch)
        .toList();
  }

  @override
  Future<Media> getMedia(SyncData syncData) async {
    final response = await _dio.get<String>('/${syncData.slug}');
    final document = parse(response.data);
    final detail = document.querySelector('#ani_detail')!;
    final characters = document.querySelectorAll('.block-actors-content .ltr');

    final Map<String, String> detailMap = {};

    for (var element in detail.querySelectorAll('.anisc-info .item')) {
      final key = element.querySelector(':first-child')!.text.trim();
      detailMap[key.substring(0, key.length - 1)] = element
          .querySelectorAll(':not(:first-child)')
          .map((e) => e.text.trim())
          .join(', ');
    }

    return Media(
      slug: syncData.slug,
      id: syncData.id,
      aniId: syncData.aniId,
      malId: syncData.malId,
      title: syncData.title,
      native: detailMap['Japanese'],
      synonyms: detailMap['Synonyms']!.split(', '),
      cover: syncData.cover,
      type: syncData.type,
      format: animeFormat[detail.querySelector('.item')!.text] ??
          MediaFormat.unknown,
      status: animeStatus[detailMap['Status']] ?? MediaStatus.unknown,
      description: detail.querySelector('.text')?.text.trim(),
      trailer:
          formatAnimeTrailer(document.querySelector('.screen-items .item')),
      year: int.tryParse(detailMap['Premiered']!.split(' ')[1]),
      genres: detailMap['Genres']!.split(', '),
      rating: double.tryParse(detailMap['MAL Score']!),
      characters: characters.isEmpty
          ? null
          : PaginatedData<MediaCharacter>(
              haveMore: characters.length == 6,
              data: characters.map(formatAnimeCharacter).toList(),
            ),
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseMedia media,
    int page,
  ) async {
    // TODO: implement getMediaCharacters
    throw UnimplementedError();
  }
}
