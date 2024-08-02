import 'package:animo/core/mixins/filter_mixin.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_provider.g.dart';

@Riverpod(keepAlive: true)
class FilterState extends _$FilterState with FilterMixin {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void setOption(Map<String, dynamic> option) {
    state = option;
  }

  void reset(MediaType mediatype) {
    state = getDefaultOptions(mediatype);
  }

  void set(String key, dynamic value) {
    state[key] = value;
    ref.notifyListeners();
  }
}
