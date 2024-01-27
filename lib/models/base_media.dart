enum MediaType { anime, manga, novel }

enum MediaSource { animo, anilist, myanimelist }

class BaseMedia {
  final String slug;
  final MediaType type;
  final MediaSource source;

  BaseMedia({
    required this.slug,
    required this.type,
    this.source = MediaSource.animo,
  });

  BaseMedia copyWith({
    String? slug,
    MediaType? type,
    MediaSource? source,
  }) {
    return BaseMedia(
      slug: slug ?? this.slug,
      type: type ?? this.type,
      source: source ?? this.source,
    );
  }

  @override
  String toString() => 'BaseMedia(slug: $slug, type: $type, source: $source)';

  @override
  bool operator ==(covariant BaseMedia other) {
    if (identical(this, other)) return true;

    return other.slug == slug && other.type == type && other.source == source;
  }

  @override
  int get hashCode => slug.hashCode ^ type.hashCode ^ source.hashCode;
}
