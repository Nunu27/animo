import 'package:flutter/material.dart';

abstract class Filter {
  final String label;
  final String key;

  Filter(this.label, this.key);

  Widget build(Map<String, dynamic> optionValue);
}
