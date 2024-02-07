class MediaTrailer {
  final String id;
  final String thumbnail;

  MediaTrailer({required this.id, required this.thumbnail});

  String getEmbedUrl() {
    return 'https://www.youtube.com/embed/$id?enablejsapi=1&wmode=opaque&autoplay=1';
  }

  MediaTrailer copyWith({
    String? id,
    String? thumbnail,
  }) {
    return MediaTrailer(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory MediaTrailer.fromMap(Map<String, dynamic> map) {
    return MediaTrailer(
      id: map['id'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  @override
  String toString() => 'MediaTrailer(id: $id, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant MediaTrailer other) {
    if (identical(this, other)) return true;

    return other.id == id && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => id.hashCode ^ thumbnail.hashCode;
}
