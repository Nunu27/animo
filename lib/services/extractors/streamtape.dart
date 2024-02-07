import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/content/video_data.dart';

part 'streamtape.g.dart';

@riverpod
StreamTape streamTape(StreamTapeRef ref) {
  return StreamTape();
}

class StreamTape implements VideoExtractor {
  @override
  Future<VideoData> extract(String url) {
    // TODO: implement extract
    throw UnimplementedError();
  }
}
