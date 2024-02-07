import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/services/meta_sources/anilist/anilist_lut.dart';

MediaTrailer? formatALTrailer(trailer) {
  if (trailer == null || trailer['site'] != 'youtube') return null;

  return MediaTrailer(
    id: trailer['id'],
    thumbnail: trailer['thumbnail'],
  );
}

MediaCharacter formatALCharacter(e) => MediaCharacter(
      slug: e['node']['id'].toString(),
      name: e['node']['name']['userPreferred'],
      cover: e['node']['image']?['medium'],
      role: anilistRole[e['role']] ?? CharacterRole.background,
    );
MediaRelation formatALRelation(e) {
  final type =
      MediaType.values.byName((e['node']['type'] as String).toLowerCase());

  return MediaRelation(
    slug: e['node']['id'].toString(),
    type: type == MediaType.manga && e['node']['format'] == 'NOVEL'
        ? MediaType.novel
        : type,
    relationType: anilistRelation[e['relation']] ?? RelationType.other,
  );
}
