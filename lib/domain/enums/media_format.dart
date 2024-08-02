// ignore_for_file: constant_identifier_names

import 'package:animo/domain/enums/media_type.dart';

enum MediaFormat {
  unknown('Unknown'),

  // Anime
  TV('TV', MediaType.ANIME),
  TV_SHORT('TV Short', MediaType.ANIME),
  MOVIE('Movie', MediaType.ANIME),
  SPECIAL('Special', MediaType.ANIME),
  OVA('OVA', MediaType.ANIME),
  ONA('ONA', MediaType.ANIME),
  MUSIC('Music', MediaType.ANIME),

  // Manga
  MANGA('Manga', MediaType.MANGA),
  NOVEL('Novel'),
  ONESHOT('One-shot', MediaType.MANGA),
  DOUJINSHI('Doujinshi', MediaType.MANGA);

  const MediaFormat(this.text, [this.type]);

  final String text;
  final MediaType? type;
}
