import 'package:animo/core/dependencies/repositories.dart';
import 'package:animo/domain/entities/feed.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meta_controller.g.dart';

@riverpod
Future<Feed> getFeed(GetFeedRef ref, MediaType type) {
  return ref.watch(metaRepositoryProvider).getFeed(type);
}

class MetaController {}
