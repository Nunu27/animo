import 'package:animo/models/abstract/filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:flutter/material.dart';

class MultiSelectFilter extends Filter {
  final List<SelectOption> options;

  MultiSelectFilter(super.label, super.key, this.options);

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
