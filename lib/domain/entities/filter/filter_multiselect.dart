part of 'filter.dart';

final class FilterMultiSelect extends Filter {
  final Map<String, String> options;

  const FilterMultiSelect(super.label, super.key, this.options);

  @override
  List<Object?> get props => [label, key, options];
}
