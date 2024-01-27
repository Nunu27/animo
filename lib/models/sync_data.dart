import 'package:animo/models/base_media.dart';

class SyncData extends BaseMedia {
  final String id;
  final int? aniId;
  final int? malId;
  final String title;
  final String? cover;

  SyncData({
    required this.id,
    this.aniId,
    this.malId,
    required super.slug,
    required this.title,
    this.cover,
    required super.type,
    super.source,
  });

  @override
  SyncData copyWith({
    String? id,
    int? aniId,
    int? malId,
    String? slug,
    String? title,
    String? cover,
    MediaType? type,
    MediaSource? source,
  }) {
    return SyncData(
      id: id ?? this.id,
      aniId: aniId ?? this.aniId,
      malId: malId ?? this.malId,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      type: type ?? this.type,
      source: source ?? this.source,
    );
  }

  String getSlugOfSource(MediaSource source) {
    switch (source) {
      case MediaSource.animo:
        return slug;
      case MediaSource.anilist:
        return aniId.toString();
      case MediaSource.myanimelist:
        return malId.toString();
    }
  }

  BaseMedia toBaseMedia(MediaSource source) {
    return BaseMedia(slug: slug, type: type, source: source);
  }

  factory SyncData.fromMap(Map<String, dynamic> map) {
    return SyncData(
      id: map['id'] as String,
      aniId: map['aniId'] != null ? map['aniId'] as int : null,
      malId: map['malId'] != null ? map['malId'] as int : null,
      slug: map['slug'] as String,
      title: map['title'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      type: MediaType.values.byName(map['type']),
    );
  }

  @override
  String toString() {
    return 'SyncData(id: $id, aniId: $aniId, malId: $malId, slug: $slug, title: $title, cover: $cover, type: $type)';
  }

  @override
  bool operator ==(covariant SyncData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.aniId == aniId &&
        other.malId == malId &&
        other.slug == slug &&
        other.title == title &&
        other.cover == cover &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        aniId.hashCode ^
        malId.hashCode ^
        slug.hashCode ^
        title.hashCode ^
        cover.hashCode ^
        type.hashCode;
  }
}
