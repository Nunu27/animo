import 'package:equatable/equatable.dart';

part 'filter_select.dart';
part 'filter_input.dart';
part 'filter_multiselect.dart';
part 'filter_checkbox.dart';
part 'filter_range.dart';

sealed class Filter extends Equatable {
  final String label;
  final String key;

  const Filter(this.label, this.key);

  @override
  List<Object?> get props => [label, key];
}
