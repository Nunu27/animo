import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:html/dom.dart';

const noImage = 'https://cdn.novelupdates.com/imgmid/noimagemid.jpg';

MediaBasic formatNovelBasicSearch(Element e) {
  final splittedUrl = e.attributes['href']!.split('/');
  final cover = 'https:${e.querySelector('img')!.attributes['src']}';

  return MediaBasic(
    slug: splittedUrl[splittedUrl.length - 2],
    cover: cover == noImage ? null : cover,
    title: e.text.trim(),
    type: MediaType.novel,
  );
}

MediaBasic formatNovelFilter(Element e) {
  final a = e.querySelector('a')!;

  final splittedUrl = a.attributes['href']!.split('/');
  final cover = e.querySelector('img')!.attributes['src'];

  return MediaBasic(
    slug: splittedUrl[splittedUrl.length - 2],
    cover: cover == noImage ? null : cover,
    title: a.text.trim(),
    info: e.querySelector('.ss_desk')!.text.trim(),
    type: MediaType.novel,
  );
}
