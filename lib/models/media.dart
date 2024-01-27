import 'package:animo/models/base_media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_relation.dart';
import 'package:animo/models/media_trailer.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:flutter/foundation.dart';
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
  unknown(Icons.question_mark, "Unknown"),
  upcoming(Icons.upcoming, 'Upcoming'),
  ongoing(Icons.access_time, 'Ongoing'),
  completed(Icons.done_all, 'Completed'),
  cancelled(Icons.cancel, 'Cancelled'),
  hiatus(Icons.hourglass_empty_rounded, 'Hiatus');

  const MediaStatus(this.icon, this.text);

  final IconData icon;
  final String text;
}

class Media extends BaseMedia {
  final String id;
  final int? aniId;
  final int? malId;
  final String title;
  final String? native;
  final List<String> synonyms;
  final String? cover;
  final String? banner;
  final MediaFormat format;
  final MediaStatus status;
  final String? description;
  final MediaTrailer? trailer;
  final int? year;
  final List<String> genres;
  final double? rating;
  final PaginatedData<MediaCharacter>? characters;
  final PaginatedData<MediaRelation>? relations;
  final List<String> langList;

  Media({
    required super.slug,
    required this.id,
    this.aniId,
    this.malId,
    required this.title,
    this.native,
    this.synonyms = const [],
    this.cover,
    this.banner,
    required super.type,
    required this.format,
    required this.status,
    this.description,
    this.trailer,
    this.year,
    required this.genres,
    this.rating,
    this.characters,
    this.relations,
    this.langList = const [],
    super.source = MediaSource.animo,
  });

  @override
  Media copyWith({
    String? slug,
    String? id,
    int? aniId,
    int? malId,
    String? title,
    String? native,
    List<String>? synonyms,
    String? cover,
    String? banner,
    MediaType? type,
    MediaFormat? format,
    MediaStatus? status,
    String? description,
    MediaTrailer? trailer,
    int? year,
    List<String>? genres,
    double? rating,
    PaginatedData<MediaCharacter>? characters,
    PaginatedData<MediaRelation>? relations,
    List<String>? langList,
    MediaSource? source,
  }) {
    return Media(
      slug: slug ?? this.slug,
      id: id ?? this.id,
      aniId: aniId ?? this.aniId,
      malId: malId ?? this.malId,
      title: title ?? this.title,
      native: native ?? this.native,
      synonyms: synonyms ?? this.synonyms,
      cover: cover ?? this.cover,
      banner: banner ?? this.banner,
      type: type ?? this.type,
      format: format ?? this.format,
      status: status ?? this.status,
      description: description ?? this.description,
      trailer: trailer ?? this.trailer,
      year: year ?? this.year,
      genres: genres ?? this.genres,
      rating: rating ?? this.rating,
      characters: characters ?? this.characters,
      relations: relations ?? this.relations,
      langList: langList ?? this.langList,
      source: source ?? this.source,
    );
  }

  MediaBasic toMediaBasic() {
    return MediaBasic(slug: slug, cover: cover, title: title, type: type);
  }

  @override
  String toString() {
    return 'Media(slug: $slug, id: $id, aniId: $aniId, malId: $malId, title: $title, native: $native, synonyms: $synonyms, cover: $cover, banner: $banner, type: $type, format: $format, status: $status, description: $description, trailer: $trailer, year: $year, genres: $genres, rating: $rating, characters: $characters, relations: $relations, langList: $langList, source: $source)';
  }

  @override
  bool operator ==(covariant Media other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.id == id &&
        other.aniId == aniId &&
        other.malId == malId &&
        other.title == title &&
        other.native == native &&
        listEquals(other.synonyms, synonyms) &&
        other.cover == cover &&
        other.banner == banner &&
        other.type == type &&
        other.format == format &&
        other.status == status &&
        other.description == description &&
        other.trailer == trailer &&
        other.year == year &&
        listEquals(other.genres, genres) &&
        other.rating == rating &&
        other.characters == characters &&
        other.relations == relations &&
        listEquals(other.langList, langList) &&
        other.source == source;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        id.hashCode ^
        aniId.hashCode ^
        malId.hashCode ^
        title.hashCode ^
        native.hashCode ^
        synonyms.hashCode ^
        cover.hashCode ^
        banner.hashCode ^
        type.hashCode ^
        format.hashCode ^
        status.hashCode ^
        description.hashCode ^
        trailer.hashCode ^
        year.hashCode ^
        genres.hashCode ^
        rating.hashCode ^
        characters.hashCode ^
        relations.hashCode ^
        langList.hashCode ^
        source.hashCode;
  }
}
