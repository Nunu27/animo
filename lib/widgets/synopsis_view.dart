import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SynopsisView extends StatefulWidget {
  const SynopsisView({
    super.key,
    required this.text,
    this.maxChar = 150,
  });

  final String? text;
  final int maxChar;

  @override
  State<SynopsisView> createState() => _SynopsisViewState();
}

class _SynopsisViewState extends State<SynopsisView> {
  late String firstHalf;
  late String secondHalf;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    _handleText();
  }

  void _handleText() {
    final text = widget.text ?? 'Not available';

    if (text.length > widget.maxChar) {
      firstHalf = text.substring(0, widget.maxChar);
      secondHalf = text.substring(widget.maxChar, text.length);
    } else if (text.length < widget.maxChar) {
      firstHalf = text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      child: secondHalf.isEmpty
          ? HtmlWidget(
              firstHalf,
              textStyle: theme.textTheme.bodySmall,
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Column(
                children: [
                  AnimatedSize(
                    duration: Durations.short3,
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: HtmlWidget(
                      expanded ? (firstHalf + secondHalf) : ('$firstHalf...'),
                      textStyle: theme.textTheme.bodySmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        expanded ? 'Show less' : 'Show more',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
