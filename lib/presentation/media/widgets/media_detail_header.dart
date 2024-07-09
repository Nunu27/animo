import 'dart:ui';

import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/presentation/shared/widgets/cover/cover_image_ratio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaDetailHeader extends StatelessWidget {
  final Media media;

  const MediaDetailHeader({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (media.banner != null)
          CachedNetworkImage(
            imageUrl: media.cover,
            fit: BoxFit.cover,
          ),
        Positioned.fill(
          bottom: -1,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withOpacity(0.5),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 110,
                child: CoverImageRatio(
                  imageUrl: media.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    Text(
                      media.title,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text('${media.rating ?? 'N/A'}'),
                          ],
                        ),
                        Text(
                          media.type.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                        Row(
                          children: [
                            Icon(
                              media.status.icon,
                              color: theme.colorScheme.onSurface,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              media.status.anime,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
