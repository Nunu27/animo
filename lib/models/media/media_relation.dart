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
  final String id;
  final RelationType type;

  MediaRelation({
    required this.id,
    required this.type,
  });

  MediaRelation copyWith({
    String? id,
    RelationType? type,
  }) {
    return MediaRelation(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }
}