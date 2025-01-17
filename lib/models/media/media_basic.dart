import 'package:animo/utils/utils.dart';
import 'package:hive/hive.dart';

import 'package:animo/models/base_data.dart';

part 'media_basic.g.dart';

@HiveType(typeId: 1)
class MediaBasic {
  @HiveField(0)
  final String slug;
  @HiveField(1)
  final String? cover;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final MediaType type;
  @HiveField(4)
  final String? info;

  MediaBasic({
    required this.slug,
    this.cover,
    required this.title,
    required this.type,
    this.info,
  });

  MediaBasic copyWith({
    String? slug,
    String? cover,
    String? title,
    MediaType? type,
    String? info,
  }) {
    return MediaBasic(
      slug: slug ?? this.slug,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      type: type ?? this.type,
      info: info ?? this.info,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
      'cover': cover,
      'title': title,
      'type': type.name,
      'info': info,
    };
  }

  factory MediaBasic.fromMap(Map<String, dynamic> map) {
    final type = MediaType.values.byName(map['type']);
    final cover = map['cover'] != null ? map['cover'] as String : null;

    return MediaBasic(
      slug: map['slug'] as String,
      cover:
          type == MediaType.novel && cover != null ? getProxyUrl(cover) : cover,
      title: map['title'] as String,
      type: type,
      info: map['info'] != null ? map['info'] as String : null,
    );
  }

  @override
  String toString() {
    return 'MediaBasic(slug: $slug, cover: $cover, title: $title, type: $type, info: $info)';
  }

  @override
  bool operator ==(covariant MediaBasic other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.cover == cover &&
        other.title == title &&
        other.type == type &&
        other.info == info;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        cover.hashCode ^
        title.hashCode ^
        type.hashCode ^
        info.hashCode;
  }
}
