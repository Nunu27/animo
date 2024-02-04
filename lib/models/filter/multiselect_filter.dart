import 'package:animo/models/abstract/filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:animo/widgets/custon_multiselect.dart';
import 'package:flutter/material.dart';

class MultiSelectFilter extends Filter {
  final List<SelectOption> options;

  MultiSelectFilter(super.label, super.key, this.options);

  @override
  Widget build(Map<String, dynamic> optionValue) {
    print('multiselect filter : $options');
    return CustomMultiSelect(
      optionValue: optionValue,
      filterKey: key,
      label: label,
      options: options,
    );
  }
}
