import 'package:animo/domain/entities/filter/filter.dart';

class FilterSelect extends Filter {
  final Map<String, String> option;

  FilterSelect(super.label, super.key, this.option);
}
