import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const PrimaryButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
