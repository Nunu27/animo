import 'package:animo/models/abstract/filter.dart';
import 'package:flutter/material.dart';

class InputFilter extends Filter {
  final String? title;

  InputFilter(super.label, super.key, {this.title});

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
