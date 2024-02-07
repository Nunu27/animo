import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/paginated_data.dart';

abstract class MetaProvider {
  final DataSource source;

  MetaProvider(this.source);

  Future<MediaMeta> getMeta(MediaType type, int id);
  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    MediaType type,
    int id,
    int page,
  );
}
