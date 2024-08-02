import 'package:flutter/material.dart';

class DraggableBottomModalSheet<T> {
  const DraggableBottomModalSheet(
      {required this.child,
      required this.context,
      this.maxChildExpand = 0.7,
      this.appbar});

  final Widget child;
  final BuildContext context;
  final double maxChildExpand;
  final AppBar? appbar;

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
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: appbar,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                clipBehavior: Clip.hardEdge,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
