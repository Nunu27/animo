import 'package:animo/models/base_media.dart';
import 'package:animo/models/media.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';

abstract class MetaProvider {
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
      BaseMedia media, int page);
  Future<Media> getMedia(SyncData syncData);
}
