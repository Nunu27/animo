import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/presentation/shared/widgets/cover/cover_image_ratio.dart';
import 'package:flutter/material.dart';

class CardCover extends StatelessWidget {
  const CardCover({
    super.key,
    required this.media,
    this.width = 120,
    this.onTap,
  });

  final MediaBasic media;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoverImageRatio(
              imageUrl: media.cover,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              media.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
