import 'package:animo/models/identifier.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/sync_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/models/paginated_data.dart';

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

class Media {
  final String id;
  final int? aniId;
  final int? malId;
  final String slug;
  final String title;
  final String? native;
  final List<String> synonyms;
  final String? cover;
  final String? banner;
  final MediaType type;
  final MediaFormat format;
  final MediaStatus status;
  final String? description;
  final MediaTrailer? trailer;
  final int? year;
  final List<SelectOption> genres;
  final double? rating;
  final PaginatedData<MediaCharacter>? characters;
  final PaginatedData<BaseData>? relations;
  final MediaContent? firstContent;
  final MediaContent? lastContent;
  final List<String> langList;

  Media({
    required this.id,
    this.aniId,
    this.malId,
    required this.slug,
    required this.title,
    this.native,
    this.synonyms = const [],
    this.cover,
    this.banner,
    required this.type,
    required this.format,
    required this.status,
    this.description,
    this.trailer,
    this.year,
    required this.genres,
    this.rating,
    this.characters,
    this.relations,
    this.firstContent,
    this.lastContent,
    this.langList = const [],
  });

  int? getMetaId(DataSource source) {
    return switch (source) {
      DataSource.anilist => aniId,
      DataSource.myanimelist => malId,
      _ => null,
    };
  }

  Identifier getIdentifier() {
    return Identifier(id: id, slug: slug);
  }

  MediaBasic toMediaBasic() {
    return MediaBasic(
      slug: slug,
      cover: cover,
      title: title,
      type: type,
    );
  }

  SyncData toSyncData() {
    return SyncData(
      id: id,
      aniId: aniId,
      malId: malId,
      slug: slug,
      title: title,
      type: type,
    );
  }

  Media withMeta(MediaMeta meta) {
    return copyWith(
      native: meta.native,
      synonyms: meta.synonyms,
      banner: meta.banner,
      format: meta.format,
      trailer: meta.trailer,
      characters: meta.characters,
      relations: meta.relations,
    );
  }

  Media copyWith({
    String? id,
    int? aniId,
    int? malId,
    String? slug,
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
    List<SelectOption>? genres,
    double? rating,
    PaginatedData<MediaCharacter>? characters,
    PaginatedData<BaseData>? relations,
    MediaContent? firstContent,
    MediaContent? lastContent,
    List<String>? langList,
  }) {
    return Media(
      id: id ?? this.id,
      aniId: aniId ?? this.aniId,
      malId: malId ?? this.malId,
      slug: slug ?? this.slug,
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
      firstContent: firstContent ?? this.firstContent,
      lastContent: lastContent ?? this.lastContent,
      langList: langList ?? this.langList,
    );
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'] as String,
      aniId: map['aniId'] != null ? map['aniId'] as int : null,
      malId: map['malId'] != null ? map['malId'] as int : null,
      slug: map['slug'] as String,
      title: map['title'] as String,
      native: map['native'] != null ? map['native'] as String : null,
      synonyms: List<String>.from(map['synonyms']),
      cover: map['cover'] != null ? map['cover'] as String : null,
      banner: map['banner'] != null ? map['banner'] as String : null,
      type: MediaType.values.byName(map['type']),
      format: MediaFormat.values.byName(map['format']),
      status: MediaStatus.values.byName(map['status']),
      description:
          map['description'] != null ? map['description'] as String : null,
      trailer: map['trailer'] != null
          ? MediaTrailer.fromMap(map['trailer'] as Map<String, dynamic>)
          : null,
      year: map['year'] != null ? map['year'] as int : null,
      genres: List<SelectOption>.from(
        (map['genres'] as List).map<SelectOption>(
          (x) => SelectOption.fromMap(x as Map<String, dynamic>),
        ),
      ),
      rating: map['rating'] != null ? map['rating'] as double : null,
      characters: map['characters'] != null
          ? PaginatedData<MediaCharacter>.fromMap(
              map['characters'] as Map<String, dynamic>, MediaCharacter.fromMap)
          : null,
      relations: map['relations'] != null
          ? PaginatedData<BaseData>.fromMap(
              map['relations'] as Map<String, dynamic>,
              BaseData.fromRelationMap)
          : null,
      firstContent: map['firstContent'] != null
          ? MediaContent.fromMap(map['firstContent'] as Map<String, dynamic>)
          : null,
      lastContent: map['lastContent'] != null
          ? MediaContent.fromMap(map['lastContent'] as Map<String, dynamic>)
          : null,
      langList: List<String>.from(map['langList']),
    );
  }

  @override
  String toString() {
    return 'Media(id: $id, aniId: $aniId, malId: $malId, slug: $slug, title: $title, native: $native, synonyms: $synonyms, cover: $cover, banner: $banner, type: $type, format: $format, status: $status, description: $description, trailer: $trailer, year: $year, genres: $genres, rating: $rating, characters: $characters, relations: $relations, firstContent: $firstContent, lastContent: $lastContent, langList: $langList)';
  }

  @override
  bool operator ==(covariant Media other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.aniId == aniId &&
        other.malId == malId &&
        other.slug == slug &&
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
        other.firstContent == firstContent &&
        other.lastContent == lastContent &&
        listEquals(other.langList, langList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        aniId.hashCode ^
        malId.hashCode ^
        slug.hashCode ^
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
        firstContent.hashCode ^
        lastContent.hashCode ^
        langList.hashCode;
  }
}
