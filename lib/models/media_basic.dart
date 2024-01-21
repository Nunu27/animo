import 'package:hive/hive.dart';

part 'media_basic.g.dart';

@HiveType(typeId: 1)
class MediaBasic {
  @HiveField(0)
  String id = "";
  @HiveField(1)
  String? cover;
  @HiveField(2)
  String title = "";
  @HiveField(3)
  String? info;

  MediaBasic({
    required this.id,
    this.cover,
    required this.title,
    this.info,
  });

  MediaBasic copyWith({
    String? id,
    String? cover,
    String? title,
    String? info,
  }) {
    return MediaBasic(
      id: id ?? this.id,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      info: info ?? this.info,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cover': cover,
      'title': title,
      'info': info,
    };
  }

  factory MediaBasic.fromMap(Map<String, dynamic> map) {
    return MediaBasic(
      id: map['id'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      title: map['title'] as String,
      info: map['info'] != null ? map['info'] as String : null,
    );
  }

  @override
  String toString() {
    return 'MediaBasic(id: $id, cover: $cover, title: $title, info: $info)';
  }

  @override
  bool operator ==(covariant MediaBasic other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cover == cover &&
        other.title == title &&
        other.info == info;
  }

  @override
  int get hashCode {
    return id.hashCode ^ cover.hashCode ^ title.hashCode ^ info.hashCode;
  }
}
