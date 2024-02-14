import 'package:animo/models/base_data.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/services/media_provider/manga/manga_lut.dart';

MediaBasic formatMangaFilter(data) => MediaBasic(
      slug: data['slug'],
      title: data['title'],
      cover: data['cover_url'],
      info: data['last_chapter'] == null
          ? null
          : 'Chapter ${data['last_chapter']}',
      type: MediaType.manga,
    );
SelectOption formatMangaGenre(e) => SelectOption(
      e['md_genres']['name'],
      e['md_genres']['slug'],
    );
BaseData formatMangaRelation(e) => BaseData(
      slug: e['relate_to']['slug'],
      type: MediaType.manga,
      info: (mangaRelation[e['md_relates']['name']] ?? RelationType.other).text,
    );
MediaContent formatMangaContent(chapter, index) {
  final title = chapter['title'] as String?;

  return MediaContent(
    index: index,
    slug: chapter['hid'],
    number: chapter['chap'],
    parentNumber: chapter['vol'],
    title: title?.isEmpty ?? true ? null : title,
    lang: chapter['lang'],
    group: chapter['group_name'] == null
        ? null
        : List<String>.from(chapter['group_name']).join(', '),
    updatedAt: chapter['updated_at'] == null
        ? null
        : DateTime.parse(chapter['updated_at']),
  );
}
