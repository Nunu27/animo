import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoverCard extends StatelessWidget {
  const CoverCard({
    super.key,
    required this.media,
    this.width = 120,
  });

  final MediaBasic media;
  final double width;

  void goToDetail(BuildContext context) {
    context.push('/${media.type.name}/${media.slug}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => goToDetail(context),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Cover(
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
