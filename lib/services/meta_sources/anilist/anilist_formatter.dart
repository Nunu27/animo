import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/services/meta_sources/anilist/anilist_lut.dart';

MediaTrailer? formatALTrailer(trailer) {
  if (trailer == null) return null;
  final site = TrailerSite.values.byName(trailer['site']);

  return site == TrailerSite.youtube
      ? MediaTrailer(
          id: trailer['id'],
          site: site,
          thumbnail: trailer['thumbnail'],
        )
      : null;
}

MediaCharacter formatALCharacter(e) => MediaCharacter(
      id: e['node']['id'].toString(),
      name: e['node']['name']['userPreferred'],
      cover: e['node']['image']?['medium'],
      role: anilistRole[e['role']] ?? CharacterRole.background,
    );
MediaRelation formatALRelation(e) => MediaRelation(
      id: e['node']['id'].toString(),
      type: anilistRelation[e['relation']] ?? RelationType.other,
    );
