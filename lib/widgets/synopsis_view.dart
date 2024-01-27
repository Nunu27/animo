import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class SynopsisView extends StatelessWidget {
  const SynopsisView({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ExpandableText(
      text,
      style: theme.textTheme.bodySmall,
      expandText: 'show more',
      collapseText: 'show less',
      maxLines: 4,
      animation: true,
      linkColor: theme.colorScheme.primary,
      animationDuration: Durations.medium1,
    );
  }
}
