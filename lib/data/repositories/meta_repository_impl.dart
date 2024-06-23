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

const feedQuery = '''
query (\$season: MediaSeason, \$seasonYear: Int, \$nextSeason: MediaSeason, \$nextYear: Int) {
  trending: Page(page: 1, perPage: 6) {
    media(sort: TRENDING_DESC, type: ANIME, isAdult: false) {
      ...media
    }
  }
  season: Page(page: 1, perPage: 6) {
    media(season: \$season, seasonYear: \$seasonYear, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
      ...media
    }
  }
  nextSeason: Page(page: 1, perPage: 6) {
    media(season: \$nextSeason, seasonYear: \$nextYear, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
      ...media
    }
  }
  popular: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
      ...media
    }
  }
  top: Page(page: 1, perPage: 10) {
    media(sort: SCORE_DESC, type: ANIME, isAdult: false) {
      ...media
    }
  }
}

fragment media on Media {
  id
  title {
    userPreferred
  }
  coverImage {
    large
  }
  type
}
''';

const characterQuery = '''
    query (\$id: Int) {
      Character(id: \$id) {
        id
        name {
          first
          last
          native
        }
        image {
          large
        }
        description
      }
    }
  ''';

class MetaRepositoryImpl implements MetaRepository {
  final _dio = Dio(BaseOptions(baseUrl: 'https://graphql.anilist.co'));

  @override
  Future<Feed> getFeed(MediaType type) async {
    final season = MediaSeason.getCurrentSeason();
    final year = DateTime.now().year;
    final nextSeason =
        MediaSeason.values[(season.index + 1) % MediaSeason.values.length];
    final nextYear = (season == MediaSeason.FALL) ? year + 1 : year;

    final response = await _dio.post<Map<String, dynamic>>('', data: {
      'query': feedQuery,
      'variables': {
        'season': season.name,
        'seasonYear': year,
        'nextSeason': nextSeason.name,
        'nextYear': nextYear
      },
    });
    final data = response.data!['data'];

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
      'query': characterQuery,
      'variables': {
        'id': id,
      },
    });

    print(response.data);

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
  Future<Media> getDetail(int id) {
    // TODO: implement getDetail
    throw UnimplementedError();
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
