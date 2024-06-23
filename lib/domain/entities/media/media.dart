import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/entities/media/media_trailer.dart';
import 'package:animo/domain/enums/media_format.dart';
import 'package:animo/domain/enums/media_status.dart';

class Media extends MediaBasic {
  final int? malId;
  final String? banner;
  final List<String> synonyms;
  final MediaFormat format;
  final MediaStatus status;
  final String? description;
  final int? year;
  final List<String> genres;
  final double? rating;
  final List<CharacterBasic> characters;
  final List<MediaBasic> relations;
  final MediaTrailer? trailer;

  const Media({
    this.malId,
    this.banner,
    this.description,
    this.year,
    this.rating,
    this.trailer,
    required super.id,
    required super.cover,
    required super.title,
    required this.synonyms,
    required super.type,
    required this.format,
    required this.status,
    required this.genres,
    required this.characters,
    required this.relations,
  });
}
