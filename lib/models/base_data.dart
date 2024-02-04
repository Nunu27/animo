enum MediaType { anime, manga, novel }

enum DataSource { animo, anilist, myanimelist }

class BaseData {
  final String slug;
  final String? parentSlug;
  final MediaType type;
  final DataSource source;

  BaseData({
    required this.slug,
    this.parentSlug,
    required this.type,
    this.source = DataSource.animo,
  });

  BaseData copyWith({
    String? slug,
    String? parentSlug,
    MediaType? type,
    DataSource? source,
  }) {
    return BaseData(
      slug: slug ?? this.slug,
      parentSlug: parentSlug ?? this.parentSlug,
      type: type ?? this.type,
      source: source ?? this.source,
    );
  }

  @override
  bool operator ==(covariant BaseData other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.parentSlug == parentSlug &&
        other.type == type &&
        other.source == source;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        parentSlug.hashCode ^
        type.hashCode ^
        source.hashCode;
  }
}
