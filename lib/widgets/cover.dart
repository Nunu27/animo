import 'package:animo/widgets/loading_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:animo/constants/constants.dart';

class Cover extends StatelessWidget {
  const Cover({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: Constants.coverRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return _errorView(theme);
                },
                placeholder: (context, url) {
                  return const LoadingShimmer();
                },
              )
            : _errorView(theme),
      ),
    );
  }

  Container _errorView(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onBackground.withOpacity(0.05),
      ),
      child: Icon(
        Icons.broken_image_outlined,
        size: 36,
        color: theme.colorScheme.onBackground.withOpacity(0.5),
      ),
    );
  }
}
