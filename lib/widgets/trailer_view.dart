import 'package:animo/models/media/media_trailer.dart';
import 'package:animo/widgets/loading_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerView extends StatelessWidget {
  const TrailerView({
    super.key,
    required this.trailer,
  });

  final MediaTrailer trailer;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(trailer.getEmbedUrl()))) {
      throw Exception('Could not launch ${trailer.getEmbedUrl()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Trailer',
            style: theme.textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CachedNetworkImage(
                            imageUrl: trailer.thumbnail,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.broken_image_outlined,
                              );
                            },
                            placeholder: (context, url) {
                              return const LoadingShimmer();
                            },
                          ),
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
                                      theme.colorScheme.background
                                          .withOpacity(0),
                                      theme.colorScheme.background
                                          .withOpacity(0.8)
                                    ]
                                  : [
                                      theme.colorScheme.onBackground
                                          .withOpacity(0),
                                      theme.colorScheme.onBackground
                                          .withOpacity(0.8),
                                    ],
                              stops: const [0.3, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 36,
                          width: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xfff60002),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.play_arrow),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Watch on Youtube',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: isDarkMode
                                  ? theme.colorScheme.onBackground
                                  : theme.colorScheme.background,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
