import 'package:animo/models/base_data.dart';

class SyncData {
  final String id;
  final int? aniId;
  final int? malId;
  final String slug;
  final String title;
  final MediaType type;

  SyncData({
    required this.id,
    required this.aniId,
    required this.malId,
    required this.slug,
    required this.title,
    required this.type,
  });
}
