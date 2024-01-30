import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';

import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/video_content.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:animo/models/content/video_server.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/services/api.dart';
import 'package:animo/services/extractors/rapidcloud.dart';
import 'package:animo/services/extractors/streamsb.dart';
import 'package:animo/services/extractors/streamtape.dart';
import 'package:animo/services/media_sources/anime/anime_formatter.dart';
import 'package:animo/services/media_sources/anime/anime_lut.dart';
import 'package:animo/services/media_sources/anime/anime_option.dart';

final animeProvider = Provider((ref) {
  return AnimeProvider(ref);
});

class AnimeProvider extends MediaProvider<VideoContent> {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.anime,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  AnimeProvider(this._ref)
      : super(
          name: 'Anime',
          type: MediaType.anime,
          mediaQueryKey: 'keyword',
          mediaFilters: animeMediaOptions,
        );

  @override
  Future<List<MediaBasic>> basicSearch(String query) async {
    final response = await _dio.get<String>(
      '/ajax/search/suggest',
      queryParameters: {mediaQueryKey: query},
    );
    final data = jsonDecode(response.data!);

    if (!data['status']) return [];
    final document = parse(data['html']);

    return document
        .getElementsByTagName('a')
        .where((element) => element.querySelector('.film-poster') != null)
        .map(formatAnimeBasicSearch)
        .toList();
  }

  @override
  Future<PaginatedData<MediaBasic>> filter(
    Map<String, dynamic> options, {
    int page = 1,
  }) async {
    options['page'] = page;

    final response = await _dio.get<String>(
      options[mediaQueryKey] == null ? '/filter' : '/search',
      queryParameters: formatQuery(options),
    );

    final document = parse(response.data);

    return PaginatedData(
      haveMore: false,
      data: document
          .querySelectorAll('.flw-item')
          .map(formatAnimeFilter)
          .toList(),
    );
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
      detailMap[key.substring(0, key.length - 1)] =
          element.querySelector(':not(:first-child)')!.text.trim();
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
      genres: detail
          .querySelectorAll('.item-list a')
          .map(formatAnimeGenre)
          .toList(),
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
  Future<PaginatedData<MediaContent>> getMediaContents(
    SyncData syncData, {
    int page = 1,
    Map<String, dynamic> options = const {},
  }) async {
    final response = await _dio.get<String>(
      '/ajax/v2/episode/list/${syncData.id}',
    );
    final document = parse(jsonDecode(response.data!)['html']);
    final episodes = document
        .querySelectorAll('div.detail-infor-content > div > a')
        .map(formatAnimeContent)
        .toList();

    return PaginatedData(
      total: episodes.length,
      currentPage: page,
      haveMore: false,
      data: episodes,
    );
  }

  @override
  Future<ContentData<VideoContent>> getContent(
    BaseData baseContent, {
    List<MediaContent>? contents,
  }) async {
    final parent = await _ref.read(getSyncDataProvider(baseContent).future);
    final response = await _dio.get<String>(
      '/ajax/v2/episode/servers?episodeId=${baseContent.slug}',
    );
    final document = parse(jsonDecode(response.data!)['html']);
    contents ??= (await getMediaContents(parent)).data;

    return ContentData(
      parent: parent,
      data: VideoContent(
        sub: document
            .querySelectorAll('[data-type="sub"]')
            .map(formatAnimeVideo)
            .toList(),
        dub: document
            .querySelectorAll('[data-type="dub"]')
            .map(formatAnimeVideo)
            .toList(),
      ),
      current: contents.indexWhere(
        (element) => element.slug == baseContent.slug,
      ),
      contents: contents,
    );
  }

  Future<VideoData> getContentData(VideoServer video) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/ajax/v2/episode/sources?id=${video.id}',
    );
    final url = response.data!['link']!;

    return await _ref.read(_getExtractorProvider(video.server)).extract(url);
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  ) async {
    // TODO: implement getMediaCharacters
    throw UnimplementedError();
  }

  // Utils
  Provider<VideoExtractor> _getExtractorProvider(StreamingServer server) {
    switch (server) {
      case StreamingServer.vidCloud:
      case StreamingServer.vidStreaming:
        return rapidCloudProvider;
      case StreamingServer.streamSB:
        return streamSBProvider;
      case StreamingServer.streamTape:
        return streamTapeProvider;
      case StreamingServer.unsupported:
        throw 'Unsupported server';
    }
  }
}
