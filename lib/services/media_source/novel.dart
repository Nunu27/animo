import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final novelProvider = Provider((ref) {
  return NovelProvider();
});

class NovelProvider extends MediaProvider {
  @override
  Future<List<MediaBasic>> basicSearch({required String keyword}) {
    // TODO: implement basicSearch
    throw UnimplementedError();
  }

  @override
  Future<List<MediaBasic>> filter() {
    // TODO: implement filter
    throw UnimplementedError();
  }
}
