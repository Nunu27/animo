import 'package:animo/models/media.dart';
import 'package:animo/models/media_character.dart';

final Map<String, MediaFormat> animeFormat = {
  'TV': MediaFormat.tv,
  'Movie': MediaFormat.movie,
  'Special': MediaFormat.special,
  'OVA': MediaFormat.ova,
  'ONA': MediaFormat.ona,
  'Music': MediaFormat.music,
};
final Map<String, MediaStatus> animeStatus = {
  'Finished Airing': MediaStatus.completed,
  'Currently Airing': MediaStatus.ongoing,
  'Not yet aired': MediaStatus.upcoming,
};
final Map<String, CharacterRole> animeRole = {
  'Main': CharacterRole.main,
  'Supporting': CharacterRole.supporting,
};
