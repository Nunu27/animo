import 'package:animo/models/abstract/video_extractor.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rapidCloudProvider = Provider((ref) {
  return RapidCloud();
});

class RapidCloud extends VideoExtractor {
  @override
  Future<VideoData> extract(String url) async {
    // TODO: implement extract
    throw UnimplementedError();
  }
}
