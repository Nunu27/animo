import 'package:animo/domain/entities/media/media_trailer.dart';

class MediaTrailerDto extends MediaTrailer {
  const MediaTrailerDto({
    required super.id,
    required super.thumbnail,
  });

  static MediaTrailerDto? fromAnilist(Map<String, dynamic>? data) {
    return data?['site'] == 'youtube'
        ? MediaTrailerDto(
            id: data!['id'],
            thumbnail: data['thumbnail'],
          )
        : null;
  }
}
