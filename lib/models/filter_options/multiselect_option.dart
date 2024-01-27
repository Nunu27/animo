import 'package:animo/models/filter_options/filter_option.dart';
import 'package:animo/models/filter_options/select_item.dart';
import 'package:flutter/material.dart';

class MultiSelectOption extends FilterOption {
  final List<SelectItem> options;

  MultiSelectOption(super.label, super.key, this.options);

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
