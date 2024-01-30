import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:flutter/material.dart';

class CoverCardCompact extends StatelessWidget {
  const CoverCardCompact({
    super.key,
    required this.media,
    this.width,
    this.onTap,
  });

  final MediaBasic media;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(6),
        child: Stack(
          children: [
            Cover(
              imageUrl: media.cover!,
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.background.withOpacity(0),
                    theme.colorScheme.background.withOpacity(0.8),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 14,
                ),
                child: Text(
                  media.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
