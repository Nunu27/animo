import 'package:animo/models/filter/select_option.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/sync_data.dart';

class Media extends MediaMeta {
  final String? cover;
  final List<SelectOption> genres;
  final MediaContent? firstContent;
  final List<String> langList;

  Media({
    required super.slug,
    required super.id,
    super.aniId,
    super.malId,
    required super.title,
    super.native,
    super.synonyms,
    this.cover,
    super.banner,
    required super.type,
    required super.format,
    required super.status,
    super.description,
    super.trailer,
    super.year,
    required this.genres,
    super.rating,
    super.characters,
    super.relations,
    this.firstContent,
    this.langList = const [],
    super.source,
  });

  MediaBasic toMediaBasic() {
    return MediaBasic(slug: slug, cover: cover, title: title, type: type);
  }

  SyncData toSyncData() {
    return SyncData(id: id, slug: slug, cover: cover, title: title, type: type);
  }

  Media withMeta(MediaMeta meta) {
    return Media(
      slug: slug,
      id: id,
      aniId: aniId,
      malId: malId,
      title: title,
      native: meta.native ?? native,
      synonyms: meta.synonyms,
      cover: cover,
      banner: meta.banner,
      type: type,
      format: meta.format,
      status: meta.status,
      description: meta.description ?? description,
      trailer: meta.trailer ?? trailer,
      year: meta.year ?? year,
      genres: genres,
      rating: meta.rating,
      characters: meta.characters,
      relations: meta.relations,
      firstContent: firstContent,
      langList: langList,
      source: meta.source,
    );
  }
}
