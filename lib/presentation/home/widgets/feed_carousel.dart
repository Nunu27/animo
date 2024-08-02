import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/presentation/shared/widgets/cover/cover_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FeedCarousel extends StatelessWidget {
  const FeedCarousel({
    super.key,
    required this.carouselData,
  });

  final List<MediaBasic> carouselData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CarouselSlider(
      items: carouselData
          .map(
            (media) => Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.antiAlias,
              children: [
                CoverImage(imageUrl: media.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(20).copyWith(
                      top: 50,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          theme.colorScheme.shadow.withOpacity(0.9),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      media.title,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 2,
        pauseAutoPlayOnTouch: true,
      ),
    );
  }
}
