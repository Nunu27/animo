// ignore_for_file: constant_identifier_names

enum RelationType {
  ADAPTATION('Adaptation'),
  PREQUEL('Prequel'),
  SEQUEL('Sequel'),
  PARENT('Parent'),
  SIDE_STORY('Side story'),
  CHARACTER('Character'),
  SUMMARY('Summary'),
  ALTERNATIVE('Alternative'),
  SPIN_OFF('Spin Off'),
  SOURCE('Source'),
  COMPILATION('Compilation'),
  CONTAINS('Contains'),
  DOUJINSHI('Doujinshi'),
  SHARED_UNIVERSE('Shared Universe'),
  COLOURED('Coloured'),
  OTHER('Other');

  const RelationType(this.text);

  final String text;
}
