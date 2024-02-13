import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_relation.dart';

final Map<int, MediaStatus> mangaStatus = {
  1: MediaStatus.ongoing,
  2: MediaStatus.completed,
  3: MediaStatus.cancelled,
  4: MediaStatus.hiatus,
};
final Map<String, RelationType> mangaRelation = {
  'Coloured': RelationType.coloured,
  'Shared universe': RelationType.sharedUniverse,
  'Doujinshi': RelationType.doujinshi,
  'Based on': RelationType.source,
  'Spin-off': RelationType.spinOff,
};
