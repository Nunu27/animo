import 'package:animo/models/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoverCardCompact extends StatelessWidget {
  const CoverCardCompact({super.key, required this.media, this.width});

  final MediaBasic media;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        context.push('/manga', extra: media);
      },
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
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  media.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
