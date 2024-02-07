import 'package:flutter/foundation.dart';

import 'package:animo/models/content/video_server.dart';

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

  factory VideoContent.fromMap(Map<String, dynamic> map) {
    return VideoContent(
      sub: List<VideoServer>.from(
        (map['sub']).map<VideoServer>(
          (x) => VideoServer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      dub: List<VideoServer>.from(
        (map['dub']).map<VideoServer>(
          (x) => VideoServer.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
