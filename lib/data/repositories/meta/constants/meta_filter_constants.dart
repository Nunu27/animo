class MetaFilterConstants {
  static const genres = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Ecchi',
    'Fantasy',
    'Hentai',
    'Horror',
    'Mahou Shoujo',
    'Mecha',
    'Music',
    'Mystery',
    'Psychological',
    'Romance',
    'Sci-Fi',
    'Slice of Life',
    'Sports',
    'Supernatural',
    'Thriller'
  ];

  static const countries = {
    'JP': 'Japan',
    'KR': 'South Korea',
    'CN': 'China',
    'TW': 'Taiwan',
  };

  static String upperYearHandler(String value) {
    if (value.isEmpty) return value;

    final year = int.parse(value) * 10000 + 10000;
    return year.toString();
  }

  static String lowerYearHandler(String value) {
    if (value.isEmpty) return value;

    final year = int.parse(value) * 10000 - 1;
    return year.toString();
  }
}
