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
import 'package:animo/services/meta_sources/anilist/anilist_formatter.dart';
import 'package:animo/services/meta_sources/anilist/anilist_lut.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final anilistProvider = Provider((ref) {
  return Anilist(ref);
});

class Anilist extends MetaProvider {
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.anilist,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Anilist(this._ref) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final user = _ref.read(userProvider);

          if (user?.anilistToken != null) {
            options.headers['Authorization'] = 'Bearer ${user!.anilistToken}';
          }
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<MediaMeta> getMeta(SyncData syncData) async {
    final response = await _dio.post<Map<String, dynamic>>('', data: {
      'query': Constants.anilistMediaQuery,
      'variables': {
        'id': syncData.aniId,
      }
    });
    final data = response.data!['data']['Media'];

    final trailer = data['trailer'];
    final characters = data['characters']['edges'] as List<dynamic>;
    final relations = data['relations']['edges'] as List<dynamic>;

    return MediaMeta(
      slug: syncData.slug,
      id: syncData.id,
      aniId: syncData.aniId,
      malId: syncData.malId,
      title: syncData.title,
      native: data['title']['native'],
      synonyms: List<String>.from(data['synonyms']),
      banner: data['bannerImage'],
      type: syncData.type,
      format: anilistFormat[data['format']] ?? MediaFormat.unknown,
      status: anilistStatus[data['status']] ?? MediaStatus.unknown,
      description: data['description'],
      trailer: formatALTrailer(trailer),
      year: data['seasonYear'] ?? data['startDate']['year'],
      rating: data['averageScore'] == null ? null : data['averageScore'] / 10,
      characters: characters.isEmpty
          ? null
          : PaginatedData<MediaCharacter>(
              haveMore: data['characters']['pageInfo']['hasNextPage'],
              data: characters.map(formatALCharacter).toList(),
            ),
      relations: relations.isEmpty
          ? null
          : PaginatedData<MediaRelation>(
              haveMore: data['relations']['pageInfo']['hasNextPage'],
              data: relations.map(formatALRelation).toList(),
            ),
      source: DataSource.anilist,
    );
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  ) async {
    // TODO: implement getMediaCharacters
    throw UnimplementedError();
  }
}
