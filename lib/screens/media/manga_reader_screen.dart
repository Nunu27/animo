import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/image_content.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/services/media_sources/manga/manga.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MangaReaderScreen extends ConsumerStatefulWidget {
  const MangaReaderScreen({
    super.key,
    required this.baseData,
  });

  final BaseData baseData;

  @override
  ConsumerState<MangaReaderScreen> createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends ConsumerState<MangaReaderScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final ScrollController _scrollController;
  late final PhotoViewScaleStateController _photoViewScaleStateController;
  late final PhotoViewController _photoViewController;
  late Animation<double> _animation;
  Alignment _scalePosition = Alignment.center;
  bool _isOverlayVisible = false;

  MediaContent? nextChapter;
  MediaContent? prevChapter;
  Future<ContentData<List<ImageContent>>>? future;

  double get pixelRatio => View.of(context).devicePixelRatio;
  Size get size => View.of(context).physicalSize / pixelRatio;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _photoViewScaleStateController = PhotoViewScaleStateController();
    _photoViewController = PhotoViewController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween(begin: 1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.ease, parent: _animationController));
    _animation.addListener(
      () => _photoViewController.scale = _animation.value,
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      future = ref.read(mangaProvider).getContent(widget.baseData);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _photoViewScaleStateController.dispose();
    _photoViewController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void _handleNextChapter(int current, List<MediaContent> contents) {
    setState(() {
      future = ref
          .read(mangaProvider)
          .getContent(widget.baseData.copyWith(slug: nextChapter!.slug));
    });
    _updatePrevNextChapter(current - 1, contents);

    _scrollController.animateTo(0,
        duration: Durations.extralong3, curve: Curves.easeInOut);
  }

  void _handlePrevChapter(int current, List<MediaContent> contents) {
    setState(() {
      future = ref
          .read(mangaProvider)
          .getContent(widget.baseData.copyWith(slug: prevChapter!.slug));
    });
    _updatePrevNextChapter(current + 1, contents);
    _scrollController.animateTo(0,
        duration: Durations.extralong3, curve: Curves.easeInOut);
  }

  void _updatePrevNextChapter(int current, List<MediaContent> contents) {
    if (current > 0) {
      nextChapter = contents.elementAtOrNull(current - 1);
      prevChapter = contents.elementAtOrNull(current + 1);
    } else {
      nextChapter = null;
    }
  }

  void _toggleOverlay() {
    setState(
      () {
        _isOverlayVisible = !_isOverlayVisible;
      },
    );
    _isOverlayVisible
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values)
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
    final ThemeData theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          _updatePrevNextChapter(data.current, data.contents);

          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                PhotoViewGallery.builder(
                  itemCount: 2,
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
                        onTap: _toggleOverlay,
                        onDoubleTapDown: (details) {
                          _toggleScale(details.globalPosition);
                        },
                        onDoubleTap: () {},
                        child: Scrollbar(
                          controller: _scrollController,
                          radius: const Radius.circular(40),
                          thickness: 8,
                          interactive: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: data.data.length,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final double imgHeight = mediaQuery.size.width /
                                  data.data[index].w *
                                  data.data[index].h;
                              return SizedBox(
                                child: CachedNetworkImage(
                                  imageUrl: data.data[index].url,
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
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
                ),
                _appBar(mediaQuery, theme, context, data),
                _bottomNavBar(mediaQuery, theme, context, data)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorView(
            message: snapshot.error.toString(),
            onRetry: () {},
          );
        } else {
          return const Loader();
        }
      },
    );
  }

  Positioned _bottomNavBar(MediaQueryData mediaQuery, ThemeData theme,
      BuildContext context, ContentData<List<ImageContent>> data) {
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        duration: Durations.medium1,
        height: _isOverlayVisible ? kToolbarHeight : 0,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          color: theme.appBarTheme.backgroundColor!.withOpacity(0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  CustomBottomModalSheet(
                    context: context,
                    children: [
                      ChapterListView(
                        mediaType: MediaType.manga,
                        chapterList: data.contents,
                        parentSlug: data.parent.slug,
                        isModal: true,
                      )
                    ],
                  ).showModal();
                },
                icon: Icon(
                  Icons.format_list_numbered_rounded,
                  color: theme.appBarTheme.foregroundColor,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: prevChapter == null
                        ? null
                        : () => _handlePrevChapter(data.current, data.contents),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    data.contents[data.current].number,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    onPressed: nextChapter == null
                        ? null
                        : () => _handleNextChapter(data.current, data.contents),
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned _appBar(MediaQueryData mediaQuery, ThemeData theme,
      BuildContext context, ContentData<List<ImageContent>> data) {
    return Positioned(
      top: 0,
      child: AnimatedContainer(
        duration: Durations.medium1,
        height:
            _isOverlayVisible ? (mediaQuery.padding.top + kToolbarHeight) : 0,
        width: mediaQuery.size.width,
        alignment: Alignment.topCenter,
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: theme.appBarTheme.backgroundColor!.withOpacity(0.8),
          leading: BackButton(
            onPressed: () {
              context.pop();
            },
          ),
          title: ListTile(
            dense: true,
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                data.parent.title,
                style: theme.textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Chapter ${data.contents[data.current].number}',
                style: theme.textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
