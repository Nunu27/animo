import 'package:flutter/material.dart';

class DetailButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const DetailButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(
                height: 4,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
