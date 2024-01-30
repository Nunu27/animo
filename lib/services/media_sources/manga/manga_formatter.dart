import 'package:animo/models/base_data.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/services/media_sources/manga/manga_lut.dart';

MediaBasic formatMangaFilter(data) => MediaBasic(
      slug: data['slug'],
      title: data['title'],
      cover: data['cover_url'],
      info: 'Chapter ${data['last_chapter']}',
      type: MediaType.manga,
    );
SelectOption formatMangaGenre(e) => SelectOption(
      e['md_genres']['name'],
      e['md_genres']['slug'],
    );
MediaRelation formatMangaRelation(e) => MediaRelation(
      id: e['relate_to']['slug'],
      type: mangaRelation[e['md_relates']['name']] ?? RelationType.other,
    );
MediaContent formatMangaContent(chapter) => MediaContent(
      slug: chapter['hid'],
      number: chapter['chap'],
      title: chapter['title'],
      lang: chapter['lang'],
      group: chapter['group_name'] == null
          ? null
          : List<String>.from(chapter['group_name']).join(', '),
      updatedAt: chapter['updated_at'] == null
          ? null
          : DateTime.parse(chapter['updated_at']),
    );
