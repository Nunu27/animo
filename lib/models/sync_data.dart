import 'package:animo/models/base_data.dart';

class SyncData extends BaseData {
  final String id;
  final int? aniId;
  final int? malId;
  final String title;
  final String? cover;

  SyncData({
    required this.id,
    this.aniId,
    this.malId,
    required super.slug,
    required this.title,
    this.cover,
    required super.type,
    super.source,
  });

  String getSlugOfSource(DataSource source) {
    switch (source) {
      case DataSource.animo:
        return slug;
      case DataSource.anilist:
        return aniId.toString();
      case DataSource.myanimelist:
        return malId.toString();
    }
  }

  BaseData toBaseData(DataSource source) {
    return BaseData(slug: getSlugOfSource(source), type: type, source: source);
  }

  factory SyncData.fromMap(Map<String, dynamic> map) {
    return SyncData(
      id: map['id'].toString(),
      aniId: map['aniId'] != null ? map['aniId'] as int : null,
      malId: map['malId'] != null ? map['malId'] as int : null,
      slug: map['slug'] as String,
      title: map['title'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      type: MediaType.values.byName(map['type']),
    );
  }
}
