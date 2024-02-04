import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoverCardCompact extends StatelessWidget {
  const CoverCardCompact({
    super.key,
    required this.media,
    this.width,
    this.onTap,
    this.showLabel = true,
  });

  final MediaBasic media;
  final double? width;
  final VoidCallback? onTap;
  final bool showLabel;

  void goToDetail(BuildContext context) {
    context.push('/${media.type.name}/${media.slug}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: () => goToDetail(context),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(6),
        child: AspectRatio(
          aspectRatio: 225 / 350,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: Cover(
                  imageUrl: media.cover!,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDarkMode
                          ? [
                              theme.colorScheme.background.withOpacity(0),
                              theme.colorScheme.background.withOpacity(0.8)
                            ]
                          : [
                              theme.colorScheme.onBackground.withOpacity(0),
                              theme.colorScheme.onBackground.withOpacity(0.8),
                            ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    media.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: isDarkMode
                          ? theme.colorScheme.onBackground
                          : theme.colorScheme.background,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      if (media.info != null && showLabel)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Text(
                            media.info!,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
