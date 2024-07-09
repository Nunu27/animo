import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SynopsisView extends StatefulWidget {
  final String synopsis;
  final VoidCallback? callback;

  const SynopsisView({super.key, required this.synopsis, this.callback});

  @override
  State<SynopsisView> createState() => _SynopsisViewState();
}

class _SynopsisViewState extends State<SynopsisView> {
  final widgetKey = GlobalKey();
  double? actualHeight;

  bool expanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        actualHeight = widgetKey.currentContext?.size?.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = theme.textTheme.bodyMedium!.fontSize! *
        theme.textTheme.bodyMedium!.height! *
        3;
    final expandable = maxHeight < (actualHeight ?? 0);
    final double space = expandable ? 38 : 14;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(bottom: space),
            clipBehavior: Clip.antiAlias,
            child: AnimatedContainer(
              margin: const EdgeInsets.all(12).copyWith(bottom: space),
              height: actualHeight == null
                  ? 0
                  : expanded || !expandable
                      ? actualHeight
                      : maxHeight,
              duration: Durations.medium4,
              curve: Curves.fastOutSlowIn,
              onEnd: widget.callback,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  maxHeight: double.infinity,
                  child: HtmlWidget(
                    key: widgetKey,
                    widget.synopsis,
                    textStyle: theme.textTheme.bodyMedium,
                    onTapUrl: launchUrlString,
                  ),
                ),
              ),
            ),
          ),
          if (expandable)
            Positioned.fill(
              bottom: 14,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: IconButton.filled(
                  onPressed: () => setState(() {
                    expanded = !expanded;
                  }),
                  icon: AnimatedRotation(
                    duration: Durations.medium4,
                    turns: expanded ? 0.5 : 1,
                    child: const Icon(Icons.expand_more),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
