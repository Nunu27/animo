import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/cache_for.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@riverpod
Future<Media> getMedia(
  GetMediaRef ref, {
  required MediaType type,
  required String slug,
}) async {
  final media = await ref.watch(mediaRepositoryProvider).getMedia(type, slug);
  ref.cacheFor(const Duration(hours: 1));
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
  ref.cacheFor(const Duration(hours: 1));

  return result;
}

@riverpod
Future<ContentData> getContent(
  GetContentRef ref, {
  required BaseData baseContent,
  bool withContentList = false,
  int? current,
}) async {
  final result = await ref.watch(mediaRepositoryProvider).getContent(
        baseContent,
        withContentList: withContentList,
        current: current,
      );
  ref.cacheFor(const Duration(hours: 2));

  return result;
}
