import 'package:animo/models/media/media_relation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'base_data.g.dart';

@HiveType(typeId: 2)
enum MediaType {
  @HiveField(0)
  anime,
  @HiveField(1)
  manga,
  @HiveField(2)
  novel,
}

enum DataSource { animo, anilist, myanimelist }

class BaseData {
  final String slug;
  final String? parentSlug;
  final MediaType type;
  final String? info;
  final DataSource source;

  BaseData({
    required this.slug,
    this.parentSlug,
    required this.type,
    this.info,
    this.source = DataSource.animo,
  });

  BaseData copyWith({
    String? slug,
    String? parentSlug,
    MediaType? type,
    String? info,
    DataSource? source,
  }) {
    return BaseData(
      slug: slug ?? this.slug,
      parentSlug: parentSlug ?? this.parentSlug,
      type: type ?? this.type,
      info: info ?? this.info,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
      'type': type.name,
      'info': info,
    };
  }

  factory BaseData.fromMap(Map<String, dynamic> map) {
    return BaseData(
      slug: map['slug'] as String,
      parentSlug:
          map['parentSlug'] != null ? map['parentSlug'] as String : null,
      type: MediaType.values.byName(map['type']),
      info: map['info'] != null ? map['info'] as String : null,
      source: DataSource.values.byName(map['source']),
    );
  }

  factory BaseData.fromRelationMap(Map<String, dynamic> map) {
    return MediaRelation.fromMap(map).toBaseData();
  }

  @override
  String toString() {
    return 'BaseData(slug: $slug, parentSlug: $parentSlug, type: $type, info: $info, source: $source)';
  }

  @override
  bool operator ==(covariant BaseData other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.parentSlug == parentSlug &&
        other.type == type &&
        other.info == info &&
        other.source == source;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        parentSlug.hashCode ^
        type.hashCode ^
        info.hashCode ^
        source.hashCode;
  }
}
