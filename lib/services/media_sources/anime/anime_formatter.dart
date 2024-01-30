import 'package:html/dom.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/video_server.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/services/media_sources/anime/anime_lut.dart';

MediaBasic formatAnimeBasicSearch(Element e) => MediaBasic(
      slug: e.attributes['href']!.substring(1).replaceFirst('?ref=search', ''),
      title: e.querySelector('h3')!.text,
      cover: e.querySelector('img')?.attributes['data-src'],
      type: MediaType.anime,
    );
MediaBasic formatAnimeFilter(Element e) {
  final episodes = e.querySelector('tick-eps');

  return MediaBasic(
    slug: e
        .querySelector('a')!
        .attributes['href']!
        .substring(1)
        .replaceFirst('?ref=search', ''),
    cover: e.querySelector('img')!.attributes['data-src'],
    title: e.querySelector('.film-name')!.text,
    info: episodes == null
        ? 'Episode ${e.querySelector('.tick-sub')!.text}'
        : '${episodes.text} Episodes',
    type: MediaType.anime,
  );
}

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

SelectOption formatAnimeGenre(Element e) => SelectOption(
      e.text,
      e.attributes['href']!.split('/').last,
    );
MediaContent formatAnimeContent(Element e) => MediaContent(
      slug: e.attributes['href']!.split('=')[1],
      number: e.attributes['data-number']!,
      title: e.attributes['title'],
    );
VideoServer formatAnimeVideo(Element e) => VideoServer(
      id: int.parse(e.attributes['data-id']!),
      server: animeServer[e.attributes['data-server-id']!] ??
          StreamingServer.unsupported,
    );
