import 'package:animo/models/base_media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_character.dart';
import 'package:animo/models/media_trailer.dart';
import 'package:animo/services/lut/anime.dart';
import 'package:html/dom.dart';

MediaBasic formatAnimeBasicSearch(Element e) => MediaBasic(
      slug: e.attributes['href']!.substring(1).replaceFirst("?ref=search", ""),
      title: e.querySelector('h3')!.text,
      cover: e.querySelector('img')?.attributes['data-src'],
      type: MediaType.anime,
    );
MediaBasic formatAnimeSearch(Element e) => MediaBasic(
      slug: e
          .querySelector('a')!
          .attributes['href']!
          .substring(1)
          .replaceFirst("?ref=search", ""),
      cover: e.querySelector('img')!.attributes['data-src'],
      title: e.querySelector('.film-name')!.text,
      type: MediaType.anime,
    );
MediaTrailer? formatAnimeTrailer(Element? e) => e == null
    ? null
    : MediaTrailer(
        id: e.attributes['data-src']!.split(' ').last,
        site: TrailerSite.youtube,
        thumbnail: e.querySelector('img')!.attributes['src']!,
      );
MediaCharacter formatAnimeCharacter(Element e) {
  final a = e.querySelector('.pi-name a')!;
  return MediaCharacter(
    id: a.attributes['href']!,
    name: a.text,
    cover: e.querySelector('img')?.attributes['data-src'],
    role: animeRole[e.querySelector('.pi-cast')!.text] ??
        CharacterRole.background,
  );
}
