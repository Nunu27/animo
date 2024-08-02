import 'package:animo/domain/enums/media_type.dart';

class MetaQuery {
  static const fragment = {
    'MediaBasic': '''
fragment MediaBasic on Media {
  id
  title {
    userPreferred
  }
  coverImage {
    large
  }
  type
}
''',
  };

  static final filter = '''
query (\$page: Int = 1, \$id: Int, \$type: MediaType, \$isAdult: Boolean = false, \$search: String, \$format: [MediaFormat], \$status: MediaStatus, \$countryOfOrigin: CountryCode, \$source: MediaSource, \$season: MediaSeason, \$seasonYear: Int, \$year: String, \$onList: Boolean, \$yearLesser: FuzzyDateInt, \$yearGreater: FuzzyDateInt, \$episodeLesser: Int, \$episodeGreater: Int, \$durationLesser: Int, \$durationGreater: Int, \$chapterLesser: Int, \$chapterGreater: Int, \$volumeLesser: Int, \$volumeGreater: Int, \$licensedBy: [Int], \$isLicensed: Boolean, \$genres: [String], \$excludedGenres: [String], \$tags: [String], \$excludedTags: [String], \$minimumTagRank: Int, \$sort: [MediaSort] = [POPULARITY_DESC, SCORE_DESC]) {
  Page(page: \$page, perPage: 20) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    media(id: \$id, type: \$type, season: \$season, format_in: \$format, status: \$status, countryOfOrigin: \$countryOfOrigin, source: \$source, search: \$search, onList: \$onList, seasonYear: \$seasonYear, startDate_like: \$year, startDate_lesser: \$yearLesser, startDate_greater: \$yearGreater, episodes_lesser: \$episodeLesser, episodes_greater: \$episodeGreater, duration_lesser: \$durationLesser, duration_greater: \$durationGreater, chapters_lesser: \$chapterLesser, chapters_greater: \$chapterGreater, volumes_lesser: \$volumeLesser, volumes_greater: \$volumeGreater, licensedById_in: \$licensedBy, isLicensed: \$isLicensed, genre_in: \$genres, genre_not_in: \$excludedGenres, tag_in: \$tags, tag_not_in: \$excludedTags, minimumTagRank: \$minimumTagRank, sort: \$sort, isAdult: \$isAdult) {
      ...MediaBasic
    }
  }
}

${fragment['MediaBasic']}
''';

  static final feed = {
    MediaType.ANIME: '''
query (\$season: MediaSeason, \$seasonYear: Int, \$nextSeason: MediaSeason, \$nextYear: Int) {
  trending: Page(page: 1, perPage: 6) {
    media(sort: TRENDING_DESC, isAdult: false) {
      ...MediaBasic
    }
  }
  season: Page(page: 1, perPage: 6) {
    media(season: \$season, seasonYear: \$seasonYear, sort: POPULARITY_DESC, isAdult: false) {
      ...MediaBasic
    }
  }
  nextSeason: Page(page: 1, perPage: 6) {
    media(season: \$nextSeason, seasonYear: \$nextYear, sort: POPULARITY_DESC, isAdult: false) {
      ...MediaBasic
    }
  }
  popular: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, isAdult: false) {
      ...MediaBasic
    }
  }
}

${fragment['MediaBasic']}
''',
    MediaType.MANGA: '''
{
  trending: Page(page: 1, perPage: 6) {
    media(sort: TRENDING_DESC, type: MANGA, isAdult: false) {
      ...MediaBasic
    }
  }
  season: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, type: MANGA, isAdult: false, status: RELEASING) {
      ...MediaBasic
    }
  }
  nextSeason: Page(page: 1, perPage: 10) {
    media(sort: POPULARITY_DESC, type: MANGA, isAdult: false, status: NOT_YET_RELEASED) {
      ...MediaBasic
    }
  }
  popular: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, type: MANGA, isAdult: false) {
      ...MediaBasic
    }
  }
}

${fragment['MediaBasic']}
''',
    MediaType.NOVEL: '''
{
  trending: Page(page: 1, perPage: 6) {
    media(sort: TRENDING_DESC, type: MANGA, format: NOVEL, isAdult: false) {
      ...MediaBasic
    }
  }
  season: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, type: MANGA, format: NOVEL, isAdult: false, status: RELEASING) {
      ...MediaBasic
    }
  }
  nextSeason: Page(page: 1, perPage: 10) {
    media(sort: POPULARITY_DESC, type: MANGA, format: NOVEL, isAdult: false, status: NOT_YET_RELEASED) {
      ...MediaBasic
    }
  }
  popular: Page(page: 1, perPage: 6) {
    media(sort: POPULARITY_DESC, type: MANGA, format: NOVEL, isAdult: false) {
      ...MediaBasic
    }
  }
}

${fragment['MediaBasic']}
''',
  };

  static const media = '''
query (\$id: Int) {
  Media(id: \$id) {
    id
    idMal
    title {
      userPreferred
    }
    coverImage {
      large
    }
    bannerImage
    synonyms
    type
    format
    status
    description
    startDate {
      year
    }
    genres
    meanScore
    characters {
      edges {
        role
        node {
          id
          image {
            medium
          }
          name {
            first
            middle
            last
            full
            native
            userPreferred
          }
        }
      }
      pageInfo {
        hasNextPage
      }
    }
    relations {
      edges {
        relationType
        node {
          id
          coverImage {
            medium
          }
          title {
            userPreferred
          }
          type
        }
      }
      pageInfo {
        hasNextPage
      }
    }
    trailer {
      id
      site
      thumbnail
    }
  }
}
''';
  static const character = '''
query (\$id: Int) {
  Character(id: \$id) {
    id
    name {
      first
      last
      native
    }
    image {
      large
    }
    description
  }
}
''';
}
