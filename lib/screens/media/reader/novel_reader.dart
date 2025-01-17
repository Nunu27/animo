import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NovelReader extends StatelessWidget {
  final String content;

  const NovelReader({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return HtmlWidget(
      content,
      textStyle: theme.textTheme.bodyMedium,
      renderMode: const ListViewMode(
        padding: EdgeInsets.all(14),
      ),
      onLoadingBuilder: (context, element, loadingProgress) =>
          Loader(value: loadingProgress),
    );
  }
}
