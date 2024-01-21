import 'package:animo/models/media_basic.dart';

abstract class MediaProvider {
  Future<List<MediaBasic>> basicSearch({required String keyword});
  Future<List<MediaBasic>> filter();

  Map<String, dynamic> formatQuery(Map<String, dynamic> map) {
    return map..removeWhere((key, value) => value == null);
  }
}
