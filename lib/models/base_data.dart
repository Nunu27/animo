enum MediaType { anime, manga, novel }

enum DataSource { animo, anilist, myanimelist }

class BaseData {
  final String slug;
  final String? parentSlug;
  final MediaType type;
  final DataSource source;

  BaseData({
    required this.slug,
    this.parentSlug,
    required this.type,
    this.source = DataSource.animo,
  });
}
