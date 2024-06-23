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
