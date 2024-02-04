import 'package:animo/models/abstract/filter.dart';
import 'package:animo/widgets/custom_input_filter.dart';
import 'package:flutter/material.dart';

class InputFilter extends Filter {
  final String? title;

  InputFilter(super.label, super.key, {this.title});

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // print('input filter : $title');
    return CustomInputFilter(
      filterKey: key,
      label: label,
      optionValue: optionValue,
      title: title,
    );
  }
}
