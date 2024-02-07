import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_relation.dart';

final Map<String, MediaFormat> malFormat = {
  'TV': MediaFormat.tv,
  'Movie': MediaFormat.movie,
  'Special': MediaFormat.special,
  'OVA': MediaFormat.ova,
  'ONA': MediaFormat.ona,
  'Music': MediaFormat.music,
  'Manga': MediaFormat.manga,
  'Manhwa': MediaFormat.manga,
  'Manhua': MediaFormat.manga,
  'OEL': MediaFormat.manga,
  'Novel': MediaFormat.novel,
  'Light Novel': MediaFormat.novel,
  'One-Shot': MediaFormat.oneShot,
  'Doujinshi': MediaFormat.doujinshi,
};
final Map<String, MediaStatus> malStatus = {
  'Finished': MediaStatus.completed,
  'Finished Airing': MediaStatus.completed,
  'Currently Airing': MediaStatus.ongoing,
  'Publishing': MediaStatus.ongoing,
  'Not yet aired': MediaStatus.upcoming,
  'Not yet published': MediaStatus.upcoming,
  'On Hiatus': MediaStatus.hiatus,
  'Discontinued': MediaStatus.cancelled,
};
final Map<String, RelationType> malRelation = {
  'Sequel': RelationType.sequel,
  'Prequel': RelationType.prequel,
  'Alternative setting': RelationType.alternative,
  'Alternative version': RelationType.alternative,
  'Side story': RelationType.sideStory,
  'Summary': RelationType.summary,
  'Full story': RelationType.source,
  'Parent story': RelationType.parent,
  'Spin-off': RelationType.spinOff,
  'Adaptation': RelationType.adaptation,
  'Character': RelationType.character,
};
final Map<String, CharacterRole> malRole = {
  'Main': CharacterRole.main,
  'Supporting': CharacterRole.supporting,
};
