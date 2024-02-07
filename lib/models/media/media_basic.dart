// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:animo/models/abstract/mappable.dart';
import 'package:animo/models/base_data.dart';

part 'media_basic.g.dart';

@HiveType(typeId: 1)
class MediaBasic implements Mappable {
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

  @override
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
    return MediaBasic(
      slug: map['slug'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      title: map['title'] as String,
      type: MediaType.values.byName(map['type']),
      info: map['info'] != null ? map['info'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaBasic.fromJson(String source) =>
      MediaBasic.fromMap(json.decode(source) as Map<String, dynamic>);

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
