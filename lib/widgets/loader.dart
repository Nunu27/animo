import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(value: value),
    );
  }
}
