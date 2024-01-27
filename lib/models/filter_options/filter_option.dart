import 'package:flutter/material.dart';

abstract class FilterOption {
  final String label;
  final String key;

  FilterOption(this.label, this.key);

  Widget build(Map<String, dynamic> optionValue);
}
