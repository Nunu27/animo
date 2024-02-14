import 'package:animo/models/abstract/feed.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:animo/models/content/video_server.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/cache_for.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
Future<List<Feed>> getFeed(
  GetFeedRef ref, {
  required MediaType type,
}) async {
  final feed = await ref.watch(mediaRepositoryProvider).feed(type);
  ref.cacheFor(const Duration(hours: 5));

  return feed;
}

@riverpod
Future<Media> getMedia(
  GetMediaRef ref, {
  required MediaType type,
  required String slug,
}) async {
  final media = await ref.watch(mediaRepositoryProvider).getMedia(type, slug);
  ref.cacheFor(const Duration(hours: 3));

  return media;
}

@riverpod
Future<List<MediaBasic>> getMediaBasic(
  GetMediaBasicRef ref, {
  required List<BaseData> list,
  required DataSource source,
}) async {
  final result = await ref.watch(mediaRepositoryProvider).getMediaBasics(
        list,
        source,
      );
  ref.keepAlive();

  return result;
}

@riverpod
Future<VideoData> getSource(GetSourceRef ref,
    {required VideoServer videoServer}) async {
  final result =
      await ref.watch(mediaRepositoryProvider).getSource(videoServer);
  ref.cacheFor(const Duration(hours: 1));

  return result;
}
