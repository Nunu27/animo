import 'package:animo/data/dto/character/character_basic_dto.dart';
import 'package:animo/data/dto/media/media_basic_dto.dart';
import 'package:animo/data/dto/media/media_trailer_dto.dart';
import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/domain/enums/media_format.dart';
import 'package:animo/domain/enums/media_status.dart';
import 'package:animo/domain/enums/media_type.dart';

class MediaDto extends Media {
  const MediaDto({
    super.idMal,
    super.banner,
    super.description,
    super.year,
    super.rating,
    super.trailer,
    required super.id,
    required super.cover,
    required super.title,
    required super.synonyms,
    required super.type,
    required super.format,
    required super.status,
    required super.genres,
    required super.characters,
    required super.relations,
  });

  factory MediaDto.fromAnilist(Map<String, dynamic> data) {
    return MediaDto(
      id: data['id'],
      idMal: data['idMal'],
      title: data['title']['userPreferred'],
      cover: data['coverImage']['medium'],
      banner: data['bannerImage'],
      synonyms: List<String>.from(data['synonyms']),
      type: MediaType.values.byName(data['type']),
      format: MediaFormat.values.byName(data['format']),
      status: MediaStatus.values.byName(data['status']),
      description: data['description'],
      year: data['startDate']['year'],
      rating: (data['meanScore'] ?? 0) / 20,
      trailer: MediaTrailerDto.fromAnilist(data['trailer']),
      genres: List<String>.from(data['genres']),
      characters: PaginatedData(
        haveNext: data['characters']['pageInfo']['hasNextPage'],
        items: (data['characters']['edges'] as List)
            .map((e) => CharacterBasicDto.fromAnilist(e))
            .toList(),
      ),
      relations: PaginatedData(
        haveNext: data['relations']['pageInfo']['hasNextPage'],
        items: (data['relations']['edges'] as List)
            .map((e) => MediaBasicDto.fromAnilistRelation(e))
            .toList(),
      ),
    );
  }
}
