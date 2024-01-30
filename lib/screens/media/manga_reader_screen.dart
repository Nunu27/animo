import 'package:animo/models/base_media.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MangaReaderScreen extends StatefulWidget {
  const MangaReaderScreen({
    super.key,
    required this.slug,
    required this.type,
    required this.chapter,
  });

  final String slug;
  final MediaType type;
  final String chapter;

  @override
  State<MangaReaderScreen> createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends State<MangaReaderScreen>
    with SingleTickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _animationController;
  late Animation<Matrix4> _animation;
  late TapDownDetails _doubleTapDetails;
  bool _isOverlayVisible = false;

  final List<String> chapterList =
      List.generate(100, (index) => 'Chapter $index');

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _transformationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
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

  void _handleNextChapter() {
    Navigator.of(context).pop();
    GoRouter.of(context).pushNamed(
      'chapter',
      pathParameters: {
        'slug': widget.slug,
        'ch': '${int.parse(widget.chapter) + 1}'
      },
    );
  }

  void _handlePrevChapter() {
    Navigator.of(context).pop();
    GoRouter.of(context).pushNamed(
      'chapter',
      pathParameters: {
        'slug': widget.slug,
        'ch': '${int.parse(widget.chapter) - 1}'
      },
    );
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
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const List<Map<String, dynamic>> imgChapters = [
      {
        'url': 'https://meo.comick.pictures/0-gG84fPNobl_1t-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/1-riBfb7Z4DpWug-m.jpg',
        'w': 984,
        'h': 1400
      },
      {
        'url': 'https://meo.comick.pictures/2-8nEx7rAiFRFRZ-m.jpg',
        'w': 984,
        'h': 1400
      },
      {
        'url': 'https://meo.comick.pictures/3-kl07X7gzeOSqr-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/4-6db-maLpHI1Yz-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/5-REA_fBoO0ORxs-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/6-ofJ8caCQ-3Eay-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/7-Vryim8Nqx-wHo-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/8-AnjHAH0kUAGYX-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/9-L5YM3n-kY0A1b-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/10-JPmJ-AH7Kwuy7-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/11-9UPh12gIFHNSc-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/12-SiHsnnIMs07Xe-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/13-N-ikGqwP_TyVu-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/14-Jd0ekUY_fY5Af-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/15-ajiBX1tDSpDTJ-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/16-f8S91o0PfB8rF-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/17-Tt-40Sh5iukD2-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/18-z4eYXzpUoKjqq-m.jpg',
        'w': 1360,
        'h': 1920
      },
      {
        'url': 'https://meo.comick.pictures/19-k4J1LpSFmCR42-m.jpg',
        'w': 1360,
        'h': 1920
      }
    ];
    final mediaQuery = MediaQuery.of(context);

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
                  itemCount: imgChapters.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final double imgHeight = mediaQuery.size.width /
                        imgChapters[index]['w'] *
                        imgChapters[index]['h'];
                    return SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: imgChapters[index]['url'],
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
                      Navigator.pop(context);
                    },
                  ),
                  title: ListTile(
                    dense: true,
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        widget.slug,
                        style: theme.textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'Chapter ${widget.chapter}',
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
                                chapterList: chapterList,
                                slug: widget.slug,
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
                            onPressed: _handlePrevChapter,
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.chapter,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          IconButton(
                            onPressed: _handleNextChapter,
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
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
  }
}
