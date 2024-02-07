import 'package:animo/models/abstract/mappable.dart';
import 'package:animo/models/base_data.dart';

enum RelationType {
  adaptation('Adaptation'),
  prequel('Prequel'),
  sequel('Sequel'),
  parent('Parent'),
  sideStory('Side story'),
  character('Character'),
  summary('Summary'),
  alternative('Alternative'),
  spinOff('Spin Off'),
  source('Source'),
  compilation('Compilation'),
  contains('Contains'),
  doujinshi('Doujinshi'),
  sharedUniverse('Shared Universe'),
  coloured('Coloured'),
  other('Other');

  const RelationType(this.text);

  final String text;
}

class MediaRelation extends BaseData implements Mappable {
  final RelationType relationType;

  MediaRelation({
    required super.slug,
    required super.type,
    required this.relationType,
  });

  @override
  MediaRelation copyWith({
    String? slug,
    String? parentSlug,
    MediaType? type,
    String? info,
    RelationType? relationType,
    DataSource? source,
  }) {
    return MediaRelation(
      slug: slug ?? this.slug,
      type: type ?? this.type,
      relationType: relationType ?? this.relationType,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
      'type': type.name,
      'info': relationType.text,
    };
  }

  factory MediaRelation.fromMap(Map<String, dynamic> map) {
    return MediaRelation(
      slug: map['slug'] as String,
      type: MediaType.values.byName(map['type']),
      relationType: RelationType.values.byName(map['relationType']),
    );
  }

  @override
  String toString() => 'MediaRelation(relationType: $relationType)';

  @override
  bool operator ==(covariant MediaRelation other) {
    if (identical(this, other)) return true;

    return other.relationType == relationType;
  }

  @override
  int get hashCode => relationType.hashCode;
}
