import 'package:animo/models/content/video_data.dart';

abstract class VideoExtractor {
  Future<VideoData> extract(String url);
}
