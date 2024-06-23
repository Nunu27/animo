// ignore_for_file: constant_identifier_names

enum MediaSeason {
  WINTER('Winter'),
  SPRING('Spring'),
  SUMMER('Summer'),
  FALL('Fall');

  const MediaSeason(this.text);
  final String text;

  static MediaSeason getCurrentSeason() {
    final DateTime now = DateTime.now();
    final int month = now.month;

    if (month == 12 || month == 1 || month == 2) {
      return MediaSeason.WINTER;
    } else if (month >= 3 && month <= 5) {
      return MediaSeason.SPRING;
    } else if (month >= 6 && month <= 8) {
      return MediaSeason.SUMMER;
    } else {
      return MediaSeason.FALL;
    }
  }
}
