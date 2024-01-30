import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';

abstract class MetaProvider {
  Future<MediaMeta> getMeta(SyncData syncData);

  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  );
}
