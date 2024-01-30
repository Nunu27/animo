import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:flutter/material.dart';

enum MediaFormat {
  unknown('Unknown'),
  tv('TV'),
  tvShort('TV short'),
  movie('Movie'),
  special('Special'),
  ova('OVA'),
  ona('OVA'),
  music('Music'),
  manga('Manga'),
  novel('Novel'),
  oneShot('One-shot'),
  doujinshi('Doujinshi');

  const MediaFormat(this.text);

  final String text;
}

enum MediaStatus {
  unknown(Icons.question_mark, 'Unknown'),
  upcoming(Icons.upcoming, 'Upcoming'),
  ongoing(Icons.access_time, 'Ongoing'),
  completed(Icons.done_all, 'Completed'),
  cancelled(Icons.cancel, 'Cancelled'),
  hiatus(Icons.hourglass_empty_rounded, 'Hiatus');

  const MediaStatus(this.icon, this.text);

  final IconData icon;
  final String text;
}

class MediaMeta extends BaseData {
  final String id;
  final int? aniId;
  final int? malId;
  final String title;
  final String? native;
  final List<String> synonyms;
  final String? banner;
  final MediaFormat format;
  final MediaStatus status;
  final String? description;
  final MediaTrailer? trailer;
  final int? year;
  final double? rating;
  final PaginatedData<MediaCharacter>? characters;
  final PaginatedData<MediaRelation>? relations;

  MediaMeta({
    required super.slug,
    required this.id,
    this.aniId,
    this.malId,
    required this.title,
    this.native,
    this.synonyms = const [],
    this.banner,
    required super.type,
    required this.format,
    required this.status,
    this.description,
    this.trailer,
    this.year,
    this.rating,
    this.characters,
    this.relations,
    super.source = DataSource.animo,
  });
}
