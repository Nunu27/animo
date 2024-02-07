// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animo/models/content/video_source.dart';
import 'package:animo/models/content/video_subtitle.dart';

class VideoData {
  final Map<String, String> headers;
  final List<VideoSource> sources;
  final List<VideoSubtitle> subtitles;

  VideoData({
    required this.headers,
    required this.sources,
    required this.subtitles,
  });

  @override
  String toString() =>
      'VideoData(headers: $headers, sources: $sources, subtitles: $subtitles)';
}
