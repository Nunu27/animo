import 'package:animo/models/content/video_server.dart';
import 'package:flutter/foundation.dart';

class VideoContent {
  final List<VideoServer> sub;
  final List<VideoServer> dub;

  VideoContent({
    required this.sub,
    required this.dub,
  });

  VideoContent copyWith({
    List<VideoServer>? sub,
    List<VideoServer>? dub,
  }) {
    return VideoContent(
      sub: sub ?? this.sub,
      dub: dub ?? this.dub,
    );
  }

  @override
  String toString() => 'VideoContent(sub: $sub, dub: $dub)';

  @override
  bool operator ==(covariant VideoContent other) {
    if (identical(this, other)) return true;

    return listEquals(other.sub, sub) && listEquals(other.dub, dub);
  }

  @override
  int get hashCode => sub.hashCode ^ dub.hashCode;
}
