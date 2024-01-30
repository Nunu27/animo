import 'package:animo/models/abstract/filter.dart';
import 'package:animo/models/filter/select_option.dart';
import 'package:flutter/material.dart';

class SelectFilter extends Filter {
  final List<SelectOption> options;

  SelectFilter(super.label, super.key, this.options);

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
