import 'package:animo/data/dto/media/media_dto.dart';
import 'package:animo/data/repositories/meta_query.dart';
import 'package:animo/domain/entities/character/character.dart';
import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/entities/feed.dart';
import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/domain/enums/character_role.dart';
import 'package:animo/domain/enums/media_season.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/domain/repositories/meta_repository.dart';
import 'package:dio/dio.dart';

class MetaRepositoryImpl implements MetaRepository {
  final _dio = Dio(BaseOptions(baseUrl: 'https://graphql.anilist.co'));

  Future<Map<String, dynamic>> query(
      String query, Map<String, dynamic> variables) async {
    final response = await _dio.post<Map<String, dynamic>>('', data: {
      'query': query,
      'variables': variables,
    });
    return response.data!['data'];
  }

  @override
  Future<Feed> getFeed(MediaType type) async {
    final season = MediaSeason.getCurrentSeason();
    final year = DateTime.now().year;
    final nextSeason =
        MediaSeason.values[(season.index + 1) % MediaSeason.values.length];
    final nextYear = (season == MediaSeason.FALL) ? year + 1 : year;

    final data = await query(MetaQuery.feed[type]!, {
      'season': season.name,
      'seasonYear': year,
      'nextSeason': nextSeason.name,
      'nextYear': nextYear,
    });

    return Feed(
      carousel: (data['popular']['media'] as List)
          .map((e) => MediaBasic.fromAnilist(e))
          .toList(),
      trending: (data['trending']['media'] as List)
          .map((e) => MediaBasic.fromAnilist(e))
          .toList(),
      popularThisSeason: (data['season']['media'] as List)
          .map((e) => MediaBasic.fromAnilist(e))
          .toList(),
      upcoming: (data['nextSeason']['media'] as List)
          .map((e) => MediaBasic.fromAnilist(e))
          .toList(),
    );
  }

  @override
  Future<PaginatedData<MediaBasic>> filter() {
    // TODO: implement filter
    throw UnimplementedError();
  }

  @override
  Future<Character> getCharacter(int id) async {
    final response = await _dio.post<Map<String, dynamic>>('', data: {
      'query': MetaQuery.character,
      'variables': {
        'id': id,
      },
    });

    return Character(
      id: id,
      name: 'asdasd',
      role: CharacterRole.MAIN,
    );
  }

  @override
  Future<MediaBasic> getCharacterMedia(
    int id, [
    MediaType? type,
    int page = 1,
  ]) {
    // TODO: implement getCharacterMedia
    throw UnimplementedError();
  }

  @override
  Future<Media> getMedia(int id) async {
    final data = await query(MetaQuery.media, {'id': id});

    return MediaDto.fromAnilist(data['Media']);
  }

  @override
  Future<PaginatedData<CharacterBasic>> getMediaCharacters(
    int id, [
    int page = 1,
  ]) {
    // TODO: implement getMediaCharacters
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<MediaBasic>> getMediaRelations(
    int id, [
    int page = 1,
  ]) {
    // TODO: implement getMediaRelations
    throw UnimplementedError();
  }
}
