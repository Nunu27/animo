import 'package:animo/presentation/shared/widgets/loading_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final double? width;
  final String? imageUrl;

  const CoverImage({
    super.key,
    required this.imageUrl,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: width,
              errorWidget: (context, url, error) {
                return _errorView(theme);
              },
              placeholder: (context, url) {
                return const LoadingShimmer();
              },
            )
          : _errorView(theme),
    );
  }

  Container _errorView(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withOpacity(0.05),
      ),
      child: Icon(
        Icons.broken_image_outlined,
        size: 36,
        color: theme.colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}
