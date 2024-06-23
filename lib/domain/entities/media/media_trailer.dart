import 'package:equatable/equatable.dart';

class MediaTrailer extends Equatable {
  final String id;
  final String thumbnail;

  const MediaTrailer({required this.id, required this.thumbnail});

  String getEmbedUrl() {
    return 'https://www.youtube.com/embed/$id?enablejsapi=1&wmode=opaque&autoplay=1';
  }

  factory MediaTrailer.fromMap(Map<String, dynamic> map) {
    return MediaTrailer(
      id: map['id'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  @override
  List<Object?> get props => [id, thumbnail];
}
