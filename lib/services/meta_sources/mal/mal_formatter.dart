import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/services/meta_sources/mal/mal_lut.dart';

MediaTrailer? formatMALTrailer(trailer) => trailer == null
    ? null
    : MediaTrailer(
        id: trailer['youtube_id'],
        site: TrailerSite.youtube,
        thumbnail: trailer['images']['large_image_url'],
      );
MediaCharacter formatMALCharacter(e) => MediaCharacter(
      id: e['character']['mal_id'].toString(),
      name: e['character']['name'],
      cover: e['character']['images']['webp']['image_url'],
      role: malRole[e['role']] ?? CharacterRole.background,
    );
