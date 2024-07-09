// ignore_for_file: constant_identifier_names

enum MediaFormat {
  unknown('Unknown'),

  // Anime
  TV('TV'),
  TV_SHORT('TV short'),
  MOVIE('Movie'),
  SPECIAL('Special'),
  OVA('OVA'),
  ONA('ONA'),
  MUSIC('Music'),

  // Manga
  MANGA('Manga'),
  NOVEL('Novel'),
  ONESHOT('One-shot'),
  DOUJINSHI('Doujinshi');

  const MediaFormat(this.text);

  final String text;
}
