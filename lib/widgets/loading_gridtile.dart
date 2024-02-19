import 'package:animo/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingGridTile extends StatelessWidget {
  const LoadingGridTile({
    super.key,
    required this.itemCount,
    required this.column,
  });

  final int itemCount;
  final int column;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 0),
      itemCount: 15,
      itemBuilder: (context, index) {
        return GridTile(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.onBackground.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const LoadingShimmer(),
            ),
          ),
        );
      },
    );
  }
}
