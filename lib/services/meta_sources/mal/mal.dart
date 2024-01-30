import 'package:animo/constants/constants.dart';
import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/abstract/meta_provider.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/services/meta_sources/mal/mal_formatter.dart';
import 'package:animo/services/meta_sources/mal/mal_lut.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final malProvider = Provider((ref) {
  return MAL(ref);
});

class MAL extends MetaProvider {
  final Ref _ref;
  final Dio _jikan = Dio(
    BaseOptions(
      baseUrl: URLConstants.jikan,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  final Dio _mal = Dio(
    BaseOptions(
      baseUrl: URLConstants.mal,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  MAL(this._ref) {
    _mal.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final user = _ref.read(userProvider);

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
  Future<MediaMeta> getMeta(SyncData syncData) async {
    final malType =
        syncData.type == MediaType.novel ? MediaType.manga : syncData.type;

    final response = await _jikan
        .get<Map<String, dynamic>>('/${malType.name}/${syncData.malId}/full');
    final data = response.data!['data'];

    final relationData = data['relations'] as List<dynamic>;
    final List<MediaRelation> relations = [];

    for (var relation in relationData) {
      for (var entry in relation['entry']) {
        relations.add(
          MediaRelation(
            id: entry['mal_id'].toString(),
            type: malRelation[relation['relation']] ?? RelationType.other,
          ),
        );
      }
    }

    return MediaMeta(
      slug: syncData.slug,
      id: syncData.id,
      aniId: syncData.aniId,
      malId: syncData.malId,
      title: syncData.title,
      native: data['title_japanese'],
      synonyms: List<String>.from(data['title_synonyms']),
      type: syncData.type,
      format: malFormat[data['type']] ?? MediaFormat.unknown,
      status: malStatus[data['status']] ?? MediaStatus.unknown,
      description: data['synopsis'],
      trailer: formatMALTrailer(data['trailer']),
      year: data['year'],
      rating: data['score'],
      characters: await getMediaCharacters(
        syncData.toBaseData(DataSource.myanimelist),
        1,
      ),
      relations: relations.isEmpty
          ? null
          : PaginatedData<MediaRelation>(
              haveMore: false,
              data: relations,
            ),
      source: DataSource.anilist,
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  ) async {
    final malType =
        baseMedia.type == MediaType.novel ? MediaType.manga : baseMedia.type;

    final response = await _jikan.get<Map<String, dynamic>>(
      '/${malType.name}/${baseMedia.slug}/characters',
    );
    final data = response.data!['data'] as List<dynamic>;

    return PaginatedData(
      total: data.length,
      currentPage: page,
      haveMore: false,
      data: data.map(formatMALCharacter).toList(),
    );
  }
}
