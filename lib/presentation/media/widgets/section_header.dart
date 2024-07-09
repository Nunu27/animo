import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final bool usePadding;
  final bool haveMore;
  final VoidCallback? onMore;

  const SectionHeader({
    super.key,
    required this.text,
    this.usePadding = true,
    this.haveMore = false,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: usePadding ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: theme.textTheme.labelLarge,
          ),
          if (haveMore) Text('More', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
