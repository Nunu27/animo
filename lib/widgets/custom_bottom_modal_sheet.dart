import 'package:flutter/material.dart';

class CustomBottomModalSheet {
  const CustomBottomModalSheet({
    required this.children,
    required this.context,
  });

  final List<Widget> children;
  final BuildContext context;

  void showModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: children,
            );
          },
        );
      },
    );
  }
}
