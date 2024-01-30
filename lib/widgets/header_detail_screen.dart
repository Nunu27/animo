import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderDetailScreen extends StatelessWidget {
  const HeaderDetailScreen({
    super.key,
    required this.height,
    required this.url,
    this.child,
  });

  final double height;
  final String url;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Stack(
      children: [
        CachedNetworkImage(
          height: height - 2,
          width: size.width,
          imageUrl: url,
          fit: BoxFit.cover,
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.background.withOpacity(0.5),
                theme.colorScheme.background,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        if (child != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: child,
          )
      ],
    );
  }
}
