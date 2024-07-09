import 'package:animo/core/dependencies/repositories.dart';
import 'package:animo/core/utils/cache_for.dart';
import 'package:animo/domain/entities/feed.dart';
import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meta_controller.g.dart';

@riverpod
Future<Feed> getFeed(GetFeedRef ref, MediaType type) async {
  final repository = ref.watch(metaRepositoryProvider);
  final data = await repository.getFeed(type);

  ref.cacheFor(const Duration(hours: 3));

  return data;
}

@riverpod
Future<Media> getMedia(GetMediaRef ref, int id) {
  return ref.watch(metaRepositoryProvider).getMedia(id);
}

class MetaController {}
