// ignore_for_file: constant_identifier_names

enum MediaSource {
  ORIGINAL('Original'),
  MANGA('Manga'),
  LIGHT_NOVEL('Light Novel'),
  VISUAL_NOVEL('Visual Novel'),
  VIDEO_GAME('Video Game'),
  NOVEL('Novel'),
  DOUJINSHI('Doujinshi'),
  ANIME('Anime'),
  WEB_NOVEL('Web Novel'),
  GAME('Game'),
  COMIC('Comic'),
  MULTIMEDIA_PROJECT('Multimedia Project'),
  PICTURE_BOOK('Picture Book'),
  OTHER('Other');

  const MediaSource(this.text);

  final String text;
}
