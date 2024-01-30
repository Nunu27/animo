import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:flutter/material.dart';

class CoverCard extends StatelessWidget {
  const CoverCard({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Cover(
              imageUrl: media.cover!,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              media.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall!.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
