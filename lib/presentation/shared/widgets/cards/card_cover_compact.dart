import 'package:animo/core/constants/constants.dart';
import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/presentation/shared/widgets/cover/cover_image_ratio.dart';
import 'package:flutter/material.dart';

class CardCoverCompact extends StatelessWidget {
  const CardCoverCompact({
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(6),
        child: AspectRatio(
          aspectRatio: Constants.coverRatio,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: CoverImageRatio(
                  imageUrl: media.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDarkMode
                          ? [
                              theme.colorScheme.surface.withOpacity(0),
                              theme.colorScheme.surface.withOpacity(0.8)
                            ]
                          : [
                              theme.colorScheme.onSurface.withOpacity(0),
                              theme.colorScheme.onSurface.withOpacity(0.8),
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
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.surface,
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
