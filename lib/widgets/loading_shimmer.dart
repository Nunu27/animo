import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onBackground.withOpacity(0.05),
      highlightColor: theme.colorScheme.onBackground.withOpacity(0.3),
      child: Container(
        color: theme.colorScheme.background,
      ),
    );
  }
}
