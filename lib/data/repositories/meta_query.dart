import 'package:animo/domain/enums/media_type.dart';

class MetaQuery {
  static const fragment = {
    'MediaBasic':
        'fragment MediaBasic on Media{id title{userPreferred}coverImage{large}type}',
  };

  static final feed = {
    MediaType.ANIME:
        'query(\$season:MediaSeason,\$seasonYear:Int,\$nextSeason:MediaSeason,\$nextYear:Int){trending:Page(page:1,perPage:6){media(sort:TRENDING_DESC,isAdult:false){...MediaBasic}}season:Page(page:1,perPage:6){media(season:\$season,seasonYear:\$seasonYear,sort:POPULARITY_DESC,isAdult:false){...MediaBasic}}nextSeason:Page(page:1,perPage:6){media(season:\$nextSeason,seasonYear:\$nextYear,sort:POPULARITY_DESC,isAdult:false){...MediaBasic}}popular:Page(page:1,perPage:6){media(sort:POPULARITY_DESC,isAdult:false){...MediaBasic}}} ${fragment['MediaBasic']}',
    MediaType.MANGA:
        '{trending:Page(page:1,perPage:6){media(sort:TRENDING_DESC,type:MANGA,isAdult:false){...MediaBasic}}season:Page(page:1,perPage:6){media(sort:POPULARITY_DESC,type:MANGA,isAdult:false,status:RELEASING){...MediaBasic}}nextSeason:Page(page:1,perPage:10){media(sort:POPULARITY_DESC,type:MANGA,isAdult:false,status:NOT_YET_RELEASED){...MediaBasic}}popular:Page(page:1,perPage:6){media(sort:POPULARITY_DESC,type:MANGA,isAdult:false){...MediaBasic}}} ${fragment['MediaBasic']}',
    MediaType.NOVEL:
        '{trending:Page(page:1,perPage:6){media(sort:TRENDING_DESC,type:MANGA,format:NOVEL,isAdult:false){...MediaBasic}}season:Page(page:1,perPage:6){media(sort:POPULARITY_DESC,type:MANGA,format:NOVEL,isAdult:false,status:RELEASING){...MediaBasic}}nextSeason:Page(page:1,perPage:10){media(sort:POPULARITY_DESC,type:MANGA,format:NOVEL,isAdult:false,status:NOT_YET_RELEASED){...MediaBasic}}popular:Page(page:1,perPage:6){media(sort:POPULARITY_DESC,type:MANGA,format:NOVEL,isAdult:false){...MediaBasic}}} ${fragment['MediaBasic']}',
  };

  static const media =
      'query(\$id:Int){Media(id:\$id){id idMal title{userPreferred}coverImage{medium}bannerImage synonyms type format status description startDate{year}genres meanScore characters{edges{role node{id image{medium}name{first middle last full native userPreferred}}}pageInfo{hasNextPage}}relations{edges{relationType node{id coverImage{medium}title{userPreferred}type}}pageInfo{hasNextPage}}trailer{id site thumbnail}}}';
  static const character =
      'query(\$id:Int){Character(id:\$id){id name{first last native}image{large}description}}';
}
