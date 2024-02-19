import 'package:animo/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: SizedBox(
        height: 24,
        width: 24,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LoadingShimmer(),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 24,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LoadingShimmer(),
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 48),
        child: SizedBox(
          height: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LoadingShimmer(),
          ),
        ),
      ),
    );
  }
}
