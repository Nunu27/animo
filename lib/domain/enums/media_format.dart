enum MediaFormat {
  unknown('Unknown'),

  // Anime
  tv('TV'),
  tvShort('TV short'),
  movie('Movie'),
  special('Special'),
  ova('OVA'),
  ona('OVA'),
  music('Music'),

  // Manga
  manga('Manga'),
  novel('Novel'),
  oneShot('One-shot'),
  doujinshi('Doujinshi');

  const MediaFormat(this.text);

  final String text;
}
