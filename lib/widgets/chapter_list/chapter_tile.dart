import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChapterTile extends StatelessWidget {
  final String parentSlug;
  final MediaType type;
  final MediaContent chapter;
  final Function(int)? onTap;

  const ChapterTile({
    super.key,
    required this.parentSlug,
    required this.type,
    required this.chapter,
    this.onTap,
  });

  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!(chapter.index!);
      context.pop();
    } else {
      context.pushNamed(
        'read',
        pathParameters: {
          'slug': parentSlug,
          'type': type.name,
          'chapter': chapter.slug,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: () {
        _handleTap(context);
      },
      title: Text(
        chapter.getTitle(),
        style: theme.textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: chapter.updatedAt == null
          ? null
          : Text(
              chapter.getSubtitle(),
              maxLines: 1,
              style: theme.textTheme.bodySmall,
            ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.download_for_offline_outlined,
          size: 24,
        ),
      ),
      leading: chapter.updatedAt == null ? null : chapter.getFlag(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
    );
  }
}
