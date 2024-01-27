import 'package:animo/constants/constants.dart';
import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_relation.dart';
import 'package:animo/models/meta_provider.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/services/formatter/mal.dart';
import 'package:animo/services/lut/mal.dart';
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
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  final Dio _mal = Dio(
    BaseOptions(
      baseUrl: URLConstants.mal,
      connectTimeout: const Duration(seconds: 10),
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
                "Bearer ${user!.malToken!.accessToken}";
          }
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<Media> getMedia(SyncData syncData) async {
    final malType =
        syncData.type == MediaType.novel ? MediaType.manga : syncData.type;

    final response = await _jikan
        .get<Map<String, dynamic>>('/${malType.name}/${syncData.malId}/full');
    final data = response.data!['data'];

    final genres = data['genres'] as List<dynamic>;
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

    return Media(
      slug: syncData.slug,
      id: syncData.id,
      aniId: syncData.aniId,
      malId: syncData.malId,
      title: syncData.title,
      native: data['title_japanese'],
      synonyms: List<String>.from(data['title_synonyms']),
      cover: syncData.cover,
      type: syncData.type,
      format: malFormat[data['type']] ?? MediaFormat.unknown,
      status: malStatus[data['status']] ?? MediaStatus.unknown,
      description: data['synopsis'],
      trailer: formatMALTrailer(data['trailer']),
      year: data['year'],
      genres: genres.map((e) => e['name'] as String).toList(),
      rating: data['score'],
      characters: await getMediaCharacters(
        syncData.toBaseMedia(MediaSource.myanimelist),
        1,
      ),
      relations: relations.isEmpty
          ? null
          : PaginatedData<MediaRelation>(
              haveMore: false,
              data: relations,
            ),
      source: MediaSource.anilist,
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseMedia media,
    int page,
  ) async {
    final malType =
        media.type == MediaType.novel ? MediaType.manga : media.type;

    final response = await _jikan.get<Map<String, dynamic>>(
      '/${malType.name}/${media.slug}/characters',
    );
    final data = response.data!['data'] as List<dynamic>;

    return PaginatedData(
      haveMore: false,
      data: data.map(formatMALCharacter).toList(),
    );
  }
}
