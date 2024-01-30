import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_relation.dart';
import 'package:animo/models/media_trailer.dart';
import 'package:animo/services/lut/anilist.dart';

MediaTrailer? formatALTrailer(trailer) => trailer == null
    ? null
    : MediaTrailer(
        id: trailer['id'],
        site: TrailerSite.values.byName(trailer['site']),
        thumbnail: trailer['thumbnail'],
      );
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
