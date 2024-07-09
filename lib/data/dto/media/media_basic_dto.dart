import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/domain/enums/relation_type.dart';

class MediaBasicDto extends MediaBasic {
  const MediaBasicDto({
    required super.id,
    required super.title,
    required super.type,
    required super.cover,
    super.info,
  });

  factory MediaBasicDto.fromAnilist(Map<String, dynamic> data) {
    return MediaBasicDto(
      id: data['id'],
      cover: data['coverImage']['medium'],
      title: data['title']['userPreferred'],
      type: MediaType.values.byName(data['type']),
    );
  }

  factory MediaBasicDto.fromAnilistRelation(Map<String, dynamic> data) {
    final node = data['node'];

    return MediaBasicDto(
      id: node['id'],
      cover: node['coverImage']['medium'],
      title: node['title']['userPreferred'],
      type: MediaType.values.byName(node['type']),
      info: RelationType.values.byName(data['relationType']).text,
    );
  }
}
