import 'package:animo/models/content/video_server.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_meta.dart';

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
final Map<String, StreamingServer> animeServer = {
  '1': StreamingServer.vidCloud,
  '3': StreamingServer.streamTape,
  '4': StreamingServer.vidStreaming,
  '5': StreamingServer.streamSB,
};
