import 'package:animo/models/filter_options/filter_option.dart';
import 'package:flutter/material.dart';

class InputOption extends FilterOption {
  final String? title;

  InputOption(super.label, super.key, {this.title});

  @override
  Widget build(Map<String, dynamic> optionValue) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
