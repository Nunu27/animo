import 'package:animo/models/media/media.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/constants/constants.dart';
import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/abstract/meta_provider.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/services/meta_sources/mal/mal_formatter.dart';
import 'package:animo/services/meta_sources/mal/mal_lut.dart';

part 'mal.g.dart';

@riverpod
MAL mal(MalRef ref) {
  return MAL(ref);
}

class MAL extends MetaProvider {
  final Ref _ref;
  final Dio _jikan = Dio(
    BaseOptions(
      baseUrl: URLConstants.jikan,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
    ),
  );
  final Dio _mal = Dio(
    BaseOptions(
      baseUrl: URLConstants.mal,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
    ),
  );

  MAL(this._ref) : super(DataSource.myanimelist) {
    _mal.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final user = _ref.read(userStateProvider);

          options.headers['X-MAL-CLIENT-ID'] = Constants.malClientId;
          if (user?.malToken != null) {
            options.headers['Authorization'] =
                'Bearer ${user!.malToken!.accessToken}';
          }
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<MediaMeta> getMeta(MediaType type, int id) async {
    final malType = type == MediaType.novel ? MediaType.manga : type;

    final response = await _jikan.get<Map<String, dynamic>>(
      '/${malType.name}/$id/full',
    );
    final data = response.data!['data'];

    final relationData = data['relations'] as List;
    final List<BaseData> relations = [];

    for (var relation in relationData) {
      for (var entry in relation['entry']) {
        relations.add(
          BaseData(
            slug: entry['mal_id'].toString(),
            type: MediaType.values.byName(entry['type']),
            info: (malRelation[entry['relation']] ?? RelationType.other).text,
          ),
        );
      }
    }

    return MediaMeta(
      native: data['title_japanese'],
      synonyms: List<String>.from(data['title_synonyms']),
      format: malFormat[data['type']] ?? MediaFormat.unknown,
      trailer: formatMALTrailer(data['trailer']),
      characters: await getMediaCharacters(
        malType,
        id,
        1,
      ),
      relations: relations.isEmpty
          ? null
          : PaginatedData<BaseData>(
              total: relations.length,
              haveMore: false,
              data: relations,
              source: source,
            ),
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    MediaType type,
    int id,
    int page,
  ) async {
    final response = await _jikan.get<Map<String, dynamic>>(
      '/${type.name}/$id/characters',
    );
    final data = response.data!['data'] as List;

    return PaginatedData(
      total: data.length,
      currentPage: page,
      haveMore: false,
      data: data.map(formatMALCharacter).toList(),
      source: source,
    );
  }
}
