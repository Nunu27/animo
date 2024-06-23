import 'package:animo/domain/entities/content/video_server.dart';
import 'package:equatable/equatable.dart';

class VideoContent extends Equatable {
  final List<VideoServer> sub;
  final List<VideoServer> dub;

  const VideoContent({
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
  List<Object> get props => [sub, dub];
}
