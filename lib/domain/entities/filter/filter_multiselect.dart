import 'package:animo/domain/entities/filter/filter.dart';

class FilterMultiSelect extends Filter {
  final Map<String, String> options;

  FilterMultiSelect(super.label, super.key, this.options);
}
