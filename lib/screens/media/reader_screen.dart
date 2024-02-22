import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/screens/media/reader/manga_reader.dart';
import 'package:animo/screens/media/reader/novel_reader.dart';
import 'package:animo/widgets/chapter_list/chapter_list_view.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/future_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({
    super.key,
    required this.syncData,
    required this.chapter,
    required this.chapters,
  });

  final SyncData syncData;
  final MediaContent chapter;
  final List<MediaContent>? chapters;

  @override
  ConsumerState<ReaderScreen> createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends ConsumerState<ReaderScreen>
    with SingleTickerProviderStateMixin {
  bool _isOverlayVisible = true;

  int? current;
  late List<MediaContent>? chapters = widget.chapters;

  int? nextChapter;
  int? prevChapter;
  Future<ContentData>? future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchData(widget.chapter);
    });
  }

  @override
  void dispose() {
    super.dispose();

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

  void _fetchData(MediaContent chapter) {
    if (current != null) {
      current = chapter.index;
      _updateNav();
    }
    final withContent = chapters == null;

    setState(() {
      future = ref.read(mediaRepositoryProvider).getContent(
            BaseData(slug: chapter.slug, type: widget.syncData.type),
            withContentList: withContent,
            current: chapter.index,
          );
    });

    future!.then((data) {
      if (!mounted) return;

      if (withContent) {
        chapters = data.contents;
      }

      current ??= data.current!;
      _updateNav();
      setState(() {});
    });
  }

  void _retry() {
    _fetchData(
      current == null ? widget.chapter : chapters![current!],
    );
  }

  void _fetchChapter(int index) {
    _fetchData(chapters![index]);
  }

  void _loadChapter(MediaContent chapter) {
    _fetchData(chapter);
    context.pop();
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.scrim,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleOverlay,
            behavior: HitTestBehavior.opaque,
            child: FutureView(
              future: future,
              onRetry: _retry,
              onData: (data) => widget.syncData.type == MediaType.manga
                  ? MangaReader(
                      images: data.data,
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: NovelReader(
                        content: data.data,
                      ),
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
                      widget.syncData.title,
                      style: theme.textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      (current == null ? widget.chapter : chapters![current!])
                          .getSimpleTitle(),
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
                      onPressed: chapters == null
                          ? null
                          : () {
                              CustomBottomModalSheet(
                                context: context,
                                children: [
                                  ChapterListView(
                                    type: MediaType.manga,
                                    total: chapters!.length,
                                    chapterList: chapters!,
                                    parentSlug: widget.syncData.slug,
                                    isModal: true,
                                    onTap: _loadChapter,
                                  )
                                ],
                              ).showModal();
                            },
                      icon: const Icon(Icons.format_list_numbered_rounded),
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
          )
        ],
      ),
    );
  }
}
