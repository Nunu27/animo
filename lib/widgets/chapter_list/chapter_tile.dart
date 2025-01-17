import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterTile extends ConsumerWidget {
  final String parentSlug;
  final MediaType type;
  final MediaContent chapter;
  final Function(MediaContent chapter) onTap;

  const ChapterTile({
    super.key,
    required this.parentSlug,
    required this.type,
    required this.chapter,
    required this.onTap,
  });

  void _handleTap() {
    onTap(chapter);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: _handleTap,
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
        onPressed: () {
          BotToast.showText(
            text: 'this feature is not yet implemented',
          );
        },
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
