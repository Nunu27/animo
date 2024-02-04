import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CustomBottomModalSheet<T> {
  const CustomBottomModalSheet({
    required this.children,
    required this.context,
    this.maxChildExpand = 0.7,
  });

  final List<Widget> children;
  final BuildContext context;
  final double maxChildExpand;

  Future<T?> showModal() async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: maxChildExpand,
          expand: false,
          builder: (context, scrollController) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              slivers: [
                MultiSliver(
                  children: children,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
