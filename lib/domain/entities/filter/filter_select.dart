part of 'filter.dart';

final class FilterSelect extends Filter {
  final Map<String, String> options;

  const FilterSelect(super.label, super.key, this.options);

  @override
  List<Object?> get props => [label, key, options];
}
