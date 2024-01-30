import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';
import 'package:animo/models/media/media_relation.dart';

final Map<String, MediaFormat> anilistFormat = {
  'TV': MediaFormat.tv,
  'TV_SHORT': MediaFormat.tvShort,
  'MOVIE': MediaFormat.movie,
  'SPECIAL': MediaFormat.special,
  'OVA': MediaFormat.ova,
  'ONA': MediaFormat.ona,
  'MUSIC': MediaFormat.music,
  'MANGA': MediaFormat.manga,
  'NOVEL': MediaFormat.novel,
  'ONE_SHOT': MediaFormat.oneShot,
};
final Map<String, MediaStatus> anilistStatus = {
  'FINISHED': MediaStatus.completed,
  'RELEASING': MediaStatus.ongoing,
  'NOT_YET_RELEASED': MediaStatus.upcoming,
  'CANCELLED': MediaStatus.cancelled,
  'HIATUS': MediaStatus.hiatus,
};
final Map<String, RelationType> anilistRelation = {
  'ADAPTATION': RelationType.adaptation,
  'PREQUEL': RelationType.prequel,
  'SEQUEL': RelationType.sequel,
  'PARENT': RelationType.parent,
  'SIDE_STORY': RelationType.sideStory,
  'CHARACTER': RelationType.character,
  'SUMMARY': RelationType.summary,
  'ALTERNATIVE': RelationType.alternative,
  'SPIN_OFF': RelationType.spinOff,
  'SOURCE': RelationType.source,
  'COMPILATION': RelationType.compilation,
  'CONTAINS': RelationType.contains,
};
final Map<String, CharacterRole> anilistRole = {
  'MAIN': CharacterRole.main,
  'SUPPORTING': CharacterRole.supporting,
};
