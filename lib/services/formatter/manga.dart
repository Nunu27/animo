import 'package:animo/models/base_media.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_relation.dart';
import 'package:animo/services/lut/manga.dart';

MediaBasic formatMangaFilter(data) => MediaBasic(
      slug: data['slug'],
      title: data['title'],
      cover: data['cover_url'],
      info: data['last_chapter'].toString(),
      type: MediaType.manga,
    );
MediaRelation formatMangaRelation(e) => MediaRelation(
      id: e['relate_to']['slug'],
      type: mangaRelation[e['md_relates']['name']] ?? RelationType.other,
    );
