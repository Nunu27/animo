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
  late final TransformationController _transformationController;
  late final AnimationController _animationController;
  late Animation<Matrix4> _animation;
  late TapDownDetails _doubleTapDetails;
  bool _isOverlayVisible = false;

  MediaContent? nextChapter;
  MediaContent? prevChapter;
  Future<ContentData<List<ImageContent>>>? future;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _doubleTapDetails = TapDownDetails();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(
        () {
          _transformationController.value = _animation.value;
        },
      );

    _animation = Matrix4Tween().animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
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
    _transformationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void _handleDoubleTap() {
    Matrix4 endMatrix;
    Offset position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      endMatrix = Matrix4.identity();
    } else {
      endMatrix = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  void _handleNextChapter(int current, List<MediaContent> contents) {
    setState(() {
      future = ref
          .read(mangaProvider)
          .getContent(widget.baseData.copyWith(slug: nextChapter!.slug));
    });
    _updatePrevNextChapter(current - 1, contents);
  }

  void _handlePrevChapter(int current, List<MediaContent> contents) {
    setState(() {
      future = ref
          .read(mangaProvider)
          .getContent(widget.baseData.copyWith(slug: prevChapter!.slug));
    });
    _updatePrevNextChapter(current + 1, contents);
  }

  void _updatePrevNextChapter(int current, List<MediaContent> contents) {
    nextChapter = contents.elementAtOrNull(current + 1);
    if (current > 0) {
      prevChapter = contents.elementAtOrNull(current - 1);
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
            body: Scrollbar(
              interactive: true,
              radius: const Radius.circular(40),
              thickness: 8,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _toggleOverlay,
                    onDoubleTapDown: (d) => _doubleTapDetails = d,
                    onDoubleTap: _handleDoubleTap,
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      child: ListView.builder(
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
                  Positioned(
                    top: 0,
                    child: AnimatedContainer(
                      duration: Durations.medium1,
                      height: _isOverlayVisible
                          ? (mediaQuery.padding.top + kToolbarHeight)
                          : 0,
                      width: mediaQuery.size.width,
                      alignment: Alignment.topCenter,
                      child: AppBar(
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        backgroundColor:
                            theme.appBarTheme.backgroundColor!.withOpacity(0.8),
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
                  ),
                  Positioned(
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: Durations.medium1,
                      height: _isOverlayVisible ? kToolbarHeight : 0,
                      width: mediaQuery.size.width,
                      decoration: BoxDecoration(
                        color:
                            theme.appBarTheme.backgroundColor!.withOpacity(0.8),
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
                                // TODO: reverse prev and next chapter
                                IconButton(
                                  onPressed: nextChapter == null
                                      ? null
                                      : () => _handleNextChapter(
                                          data.current, data.contents),
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
                                  onPressed: prevChapter == null
                                      ? null
                                      : () => _handlePrevChapter(
                                          data.current, data.contents),
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
}
