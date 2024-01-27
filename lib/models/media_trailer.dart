enum TrailerSite {
  youtube,
  dialymotion;
}

class MediaTrailer {
  final String id;
  final TrailerSite site;
  final String thumbnail;

  MediaTrailer({required this.id, required this.site, required this.thumbnail});

  @override
  bool operator ==(covariant MediaTrailer other) {
    if (identical(this, other)) return true;

    return other.id == id && other.site == site && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ site.hashCode ^ thumbnail.hashCode;
}
