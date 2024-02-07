import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/content/video_data.dart';

part 'streamsb.g.dart';

@riverpod
StreamSB streamSB(StreamSBRef ref) {
  return StreamSB();
}

class StreamSB implements VideoExtractor {
  @override
  Future<VideoData> extract(String url) {
    // TODO: implement extract
    throw UnimplementedError();
  }
}
