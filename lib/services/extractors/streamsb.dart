import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamSBProvider = Provider((ref) {
  return StreamSB();
});

class StreamSB extends VideoExtractor {
  @override
  Future<VideoData> extract(String url) {
    // TODO: implement extract
    throw UnimplementedError();
  }
}
