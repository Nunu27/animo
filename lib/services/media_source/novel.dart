import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_provider.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final novelProvider = Provider((ref) {
  return NovelProvider();
});

class NovelProvider extends MediaProvider {
  NovelProvider()
      : super(name: 'Novel', type: MediaType.novel, filterOptions: []);

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

  @override
  Future<Media> getMedia(SyncData syncData) {
    // TODO: implement getMedia
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseMedia media,
    int page,
  ) {
    // TODO: implement getMediaCharacters
    throw UnimplementedError();
  }
}
