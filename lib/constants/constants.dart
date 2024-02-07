class Constants {
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 20);

  static const malClientId = '14ed0de530ab04bc2354f945834a9c17';
  static const anilistMediaQuery =
      'query Media(\$id: Int!) { Media(id: \$id) { title { native } synonyms bannerImage format seasonYear trailer { id site thumbnail } characters(perPage: 6) { pageInfo { hasNextPage } edges { role node { id name { userPreferred } image { medium } } } } relations { pageInfo { hasNextPage } edges { relationType(version: 2) node { id type format } } } } } ';
}
