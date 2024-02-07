import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/models/abstract/api_repository.dart';
import 'package:animo/models/abstract/meta_provider.dart';
import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/video_server.dart';
import 'package:animo/models/identifier.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/api_client.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/services/extractors/rapidcloud.dart';
import 'package:animo/services/extractors/streamsb.dart';
import 'package:animo/services/extractors/streamtape.dart';
import 'package:animo/services/meta_sources/anilist/anilist.dart';
import 'package:animo/services/meta_sources/mal/mal.dart';
import 'package:animo/utils/utils.dart';

part 'media_repository.g.dart';

@riverpod
MediaRepository mediaRepository(MediaRepositoryRef ref) {
  return MediaRepository(ref: ref, api: ref.watch(apiClientProvider));
}

class MediaRepository extends ApiRepository {
  final Ref _ref;

  MediaRepository({required Ref ref, required Dio api})
      : _ref = ref,
        super(api);

  Future<List<MediaBasic>> basicSearch(String query, MediaType type) async {
    final request = api.post('/basic-search', data: {
      'query': query,
      'type': type.name,
    });
    final response = await handleApi(request);

    return (response.data as List).map((e) => MediaBasic.fromMap(e)).toList();
  }

  Future<PaginatedData<MediaBasic>> filter(
    MediaType type,
    Map<String, dynamic> options, {
    int page = 1,
  }) async {
    options['page'] = page;

    final request = api.get(
      '/${type.name}/filter',
      queryParameters: removeNulls(options),
    );
    final response = await handleApi(request);

    return PaginatedData<MediaBasic>.fromMap(response.data, MediaBasic.fromMap);
  }

  Future<List<MediaBasic>> getMediaBasics(
    List<BaseData> list,
    DataSource source, {
    Map<String, String>? infoMap,
  }) async {
    final request = api.post('/media-basic', data: {
      'list': list.map((e) => e.toMap()),
      'source': source.name,
    });
    final response = await handleApi(request);

    return (response.data as List).map((e) => MediaBasic.fromMap(e)).toList();
  }

  Future<Media> getMedia(MediaType type, String slug) async {
    final request = api.get('/${type.name}/$slug');
    final response = await handleApi(request);
    final media = Media.fromMap(response.data);

    final metaProvider = _getMetaProvider(media);

    if (metaProvider == null) {
      return media;
    } else {
      final provider = _ref.read(metaProvider);
      final meta = await _ref
          .read(metaProvider)
          .getMeta(type, media.getMetaId(provider.source)!);

      return media.withMeta(meta, provider.source);
    }
  }

  Future<PaginatedData<MediaContent>> getMediaContents(
    MediaType type,
    Identifier identifier, {
    int page = 1,
    Map<String, dynamic> options = const {},
  }) async {
    final request = api.post(
      '/${type.name}/contents',
      data: identifier.toMap(),
    );
    final response = await handleApi(request);

    return PaginatedData.fromMap(response.data, MediaContent.fromMap);
  }

  Future<ContentData> getContent(
    BaseData baseContent, {
    bool withContentList = false,
    int? current,
  }) async {
    final parent = await _ref.read(
      getMediaProvider(type: baseContent.type, slug: baseContent.parentSlug!)
          .future,
    );
    final syncData = parent.toSyncData();
    final request = api.get(
      '/${baseContent.type.name}/content/${baseContent.slug}',
      queryParameters: removeNulls(
        {
          'withContentList': withContentList,
          'current': current,
        },
      ),
    );
    final response = await handleApi(request);

    return ContentData.fromMap(response.data, syncData, baseContent.type);
  }

  // Utils
  AutoDisposeProvider<MetaProvider>? _getMetaProvider(Media media) {
    if (media.aniId != null) {
      return anilistProvider;
    } else if (media.malId != null) {
      return malProvider;
    } else {
      return null;
    }
  }

  AutoDisposeProvider<VideoExtractor> _getExtractorProvider(
    StreamingServer server,
  ) {
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
