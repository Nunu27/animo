import 'package:animo/models/base_media.dart';
import 'package:animo/models/filter_options/filter_option.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/meta_provider.dart';

abstract class MediaProvider extends MetaProvider {
  final String name;
  final MediaType type;
  final List<FilterOption> filterOptions;

  MediaProvider({
    required this.name,
    required this.type,
    required this.filterOptions,
  });

  Future<List<MediaBasic>> basicSearch({required String keyword});
  Future<List<MediaBasic>> filter();

  Map<String, dynamic> formatQuery(Map<String, dynamic> map) {
    return map..removeWhere((key, value) => value == null);
  }
}
