import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/models/paginated_data.dart';

class MediaMeta {
  final String? native;
  final List<String> synonyms;
  final String? banner;
  final MediaFormat format;
  final MediaTrailer? trailer;
  final PaginatedData<MediaCharacter>? characters;
  final PaginatedData<MediaRelation>? relations;

  MediaMeta({
    this.native,
    this.synonyms = const [],
    this.banner,
    required this.format,
    this.trailer,
    this.characters,
    this.relations,
  });
}
