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

class MediaRelation {
  final String slug;
  final MediaType type;
  final RelationType relationType;

  MediaRelation({
    required this.slug,
    required this.type,
    required this.relationType,
  });

  MediaRelation copyWith({
    String? slug,
    MediaType? type,
    RelationType? relationType,
  }) {
    return MediaRelation(
      slug: slug ?? this.slug,
      type: type ?? this.type,
      relationType: relationType ?? this.relationType,
    );
  }

  BaseData toBaseData() {
    return BaseData(slug: slug, type: type, info: relationType.text);
  }

  factory MediaRelation.fromMap(Map<String, dynamic> map) {
    return MediaRelation(
      slug: map['slug'] as String,
      type: MediaType.values.byName(map['type']),
      relationType: RelationType.values.byName(map['relationType']),
    );
  }

  @override
  String toString() =>
      'MediaRelation(slug: $slug, type: $type, relationType: $relationType)';

  @override
  bool operator ==(covariant MediaRelation other) {
    if (identical(this, other)) return true;

    return other.relationType == relationType;
  }

  @override
  int get hashCode => relationType.hashCode;
}
