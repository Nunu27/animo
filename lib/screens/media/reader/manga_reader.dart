import 'package:animo/models/content/image_content.dart';
import 'package:animo/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MangaReader extends StatefulWidget {
  final List<ImageContent> images;
  final VoidCallback toggleOverlay;

  const MangaReader(
      {super.key, required this.images, required this.toggleOverlay});

  @override
  State<MangaReader> createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  final PhotoViewScaleStateController _photoViewScaleStateController =
      PhotoViewScaleStateController();
  final PhotoViewController _photoViewController = PhotoViewController();
  late Animation<double> _animation;
  final _scrollController = ScrollController();

  Alignment _scalePosition = Alignment.center;

  double get pixelRatio => View.of(context).devicePixelRatio;
  Size get size => View.of(context).physicalSize / pixelRatio;

  @override
  void initState() {
    super.initState();
    _animation = Tween(begin: 1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.ease, parent: _animationController));
    _animation.addListener(
      () => _photoViewController.scale = _animation.value,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Alignment _computeAlignmentByTapOffset(Offset offset) {
    return Alignment((offset.dx - size.width / 2) / (size.width / 2),
        (offset.dy - size.height / 2) / (size.height / 2));
  }

  void _toggleScale(Offset tapPosition) {
    if (mounted) {
      setState(() {
        if (_animationController.isAnimating) {
          return;
        }
        if (_photoViewController.scale == 1.0) {
          _scalePosition = _computeAlignmentByTapOffset(tapPosition);

          if (_animationController.isCompleted) {
            _animationController.reset();
          }

          _animationController.forward();
          return;
        }

        if (_photoViewController.scale == 2.0) {
          _animationController.reverse();
          return;
        }

        _photoViewScaleStateController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return PhotoViewGallery.builder(
      itemCount: 1,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions.customChild(
          scaleStateController: _photoViewScaleStateController,
          basePosition: _scalePosition,
          controller: _photoViewController,
          onScaleEnd: (context, details, controllerValue) {
            if (controllerValue.scale! < 1) {
              _photoViewScaleStateController.reset();
            }
          },
          child: GestureDetector(
            onTap: widget.toggleOverlay,
            onDoubleTapDown: (details) {
              _toggleScale(details.globalPosition);
            },
            child: Scrollbar(
              controller: _scrollController,
              radius: const Radius.circular(40),
              thickness: 8,
              interactive: true,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.images.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final double imgHeight = mediaQuery.size.width /
                      widget.images[index].w *
                      widget.images[index].h;

                  return SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index].url,
                      progressIndicatorBuilder: (context, url, progress) {
                        return SizedBox(
                          height: imgHeight,
                          child: Loader(
                            value: progress.progress,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
