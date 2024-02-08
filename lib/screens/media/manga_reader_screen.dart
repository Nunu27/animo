import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/image_content.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/future_view.dart';
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
  final ScrollController _scrollController = ScrollController();
  final PhotoViewScaleStateController _photoViewScaleStateController =
      PhotoViewScaleStateController();
  final PhotoViewController _photoViewController = PhotoViewController();
  late final AnimationController _animationController;
  late Animation<double> _animation;
  Alignment _scalePosition = Alignment.center;
  bool _isOverlayVisible = false;

  int? current;
  List<MediaContent>? chapters;

  int? nextChapter;
  int? prevChapter;
  Future<ContentData<List<ImageContent>>>? future;

  double get pixelRatio => View.of(context).devicePixelRatio;
  Size get size => View.of(context).physicalSize / pixelRatio;

  @override
  void initState() {
    super.initState();
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
      _fetchData(widget.baseData);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _photoViewScaleStateController.dispose();
    _photoViewController.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  void _updateNav() {
    final index = current ?? 0;

    nextChapter = index > 0 ? current! - 1 : null;
    prevChapter = index < ((chapters?.length ?? 1) - 1) ? current! + 1 : null;
  }

  void _fetchData(BaseData baseContent, {int? fetchedIndex}) async {
    current = fetchedIndex;

    if (current != null) _updateNav();
    final withContent = chapters == null;

    setState(() {
      future = ref.read(mediaRepositoryProvider).getContent(
            baseContent,
            withContentList: withContent,
            current: fetchedIndex,
          );
    });

    final data = await future!;
    if (withContent) {
      chapters = data.contents;
      current ??= data.current!;
      _updateNav();
      setState(() {});
    }
  }

  void _retry() {
    _fetchData(
      current == null
          ? widget.baseData
          : widget.baseData.copyWith(slug: chapters![current!].slug),
      fetchedIndex: current,
    );
  }

  void _fetchChapter(int index) {
    _fetchData(
      widget.baseData.copyWith(slug: chapters![index].slug),
      fetchedIndex: index,
    );
    _scrollController.animateTo(0,
        duration: Durations.extralong3, curve: Curves.easeInOut);
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

    return FutureView(
      future: future,
      onData: (data) {
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
      },
      onRetry: _retry,
    );
  }

  Positioned _bottomNavBar(
    MediaQueryData mediaQuery,
    ThemeData theme,
    BuildContext context,
    ContentData<List<ImageContent>> data,
  ) {
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
                        total: chapters!.length,
                        chapterList: chapters!,
                        parentSlug: data.syncData.slug,
                        isModal: true,
                        onTap: _fetchChapter,
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
                        : () => _fetchChapter(prevChapter!),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    onPressed: nextChapter == null
                        ? null
                        : () => _fetchChapter(nextChapter!),
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
                data.syncData.title,
                style: theme.textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Chapter ${chapters?[current!].number}',
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
