import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/widgets/filter_checkbox_widget.dart';
import 'package:animo/presentation/search/widgets/filter_input_widget.dart';
import 'package:animo/presentation/search/widgets/filter_multiselect_widget.dart';
import 'package:animo/presentation/search/widgets/filter_range_widget.dart';
import 'package:animo/presentation/search/widgets/filter_select_widget.dart';
import 'package:flutter/material.dart';

class FilterView extends StatelessWidget {
  final Filter filter;

  const FilterView({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final filter = this.filter;

    return switch (filter) {
      FilterRange() => FilterRangeWidget(filter: filter),
      FilterInput() => FilterInputWidget(filter: filter),
      FilterSelect() => FilterSelectWidget(filter: filter),
      FilterCheckbox() => FilterCheckboxWidget(filter: filter),
      FilterMultiSelect() => FilterMultiSelectWidget(filter: filter),
    };
  }
}
