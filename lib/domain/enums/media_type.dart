// ignore_for_file: constant_identifier_names

enum MediaType {
  ANIME('Anime'),
  MANGA('Manga'),
  NOVEL('Novel');

  const MediaType(this.text);

  final String text;
}
