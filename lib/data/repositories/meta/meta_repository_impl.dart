import 'dart:developer';

import 'package:animo/data/dto/media/media_basic_dto.dart';
import 'package:animo/data/dto/media/media_dto.dart';
import 'package:animo/data/dto/paginated_data_dto.dart';
import 'package:animo/data/repositories/meta/constants/meta_filter_constants.dart';
import 'package:animo/data/repositories/meta/filters/anime_filters.dart';
import 'package:animo/data/repositories/meta/filters/manga_filters.dart';
import 'package:animo/data/repositories/meta/filters/novel_filters.dart';
import 'package:animo/data/repositories/meta/meta_query.dart';
import 'package:animo/domain/entities/character/character.dart';
import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/entities/feed.dart';
import 'package:animo/domain/entities/filter/filter.dart';
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

  @override
  Map<MediaType, List<Filter>> filters = {
    MediaType.ANIME: animeFilters,
    MediaType.MANGA: mangaFilters,
    MediaType.NOVEL: novelFilters,
  };

  Future<Map<String, dynamic>> _query(
    String query,
    Map<String, dynamic> variables, {
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '',
      data: {
        'query': query,
        'variables': variables,
      },
      cancelToken: cancelToken,
    );

    return response.data!['data'];
  }

  @override
  Future<Feed> getFeed(MediaType type) async {
    final season = MediaSeason.getCurrentSeason();
    final year = DateTime.now().year;
    final nextSeason =
        MediaSeason.values[(season.index + 1) % MediaSeason.values.length];
    final nextYear = (season == MediaSeason.FALL) ? year + 1 : year;

    final data = await _query(MetaQuery.feed[type]!, {
      'season': season.name,
      'seasonYear': year,
      'nextSeason': nextSeason.name,
      'nextYear': nextYear,
    });

    return Feed(
      carousel: (data['popular']['media'] as List)
          .map((e) => MediaBasicDto.fromAnilist(e))
          .toList(),
      trending: (data['trending']['media'] as List)
          .map((e) => MediaBasicDto.fromAnilist(e))
          .toList(),
      popularThisSeason: (data['season']['media'] as List)
          .map((e) => MediaBasicDto.fromAnilist(e))
          .toList(),
      upcoming: (data['nextSeason']['media'] as List)
          .map((e) => MediaBasicDto.fromAnilist(e))
          .toList(),
    );
  }

  @override
  Future<PaginatedData<MediaBasic>> filter(
    Map<String, dynamic> variables, {
    CancelToken? cancelToken,
  }) async {
    variables['yearGreater'] = MetaFilterConstants.lowerYearHandler(
      variables['yearGreater'] ?? '',
    );
    variables['yearLesser'] = MetaFilterConstants.upperYearHandler(
      variables['yearLesser'] ?? '',
    );

    variables.removeWhere((_, value) => switch (value.runtimeType) {
          String => value.isEmpty,
          _ => value == null
        });
    log(variables.toString());

    final data = await _query(
      MetaQuery.filter,
      variables,
      cancelToken: cancelToken,
    );

    return PaginatedDataDto.fromAnilist(
      data,
      'media',
      MediaBasicDto.fromAnilist,
    );
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
    final data = await _query(MetaQuery.media, {'id': id});

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
