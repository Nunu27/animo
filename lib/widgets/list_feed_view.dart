import 'package:animo/constants/constants.dart';
import 'package:animo/models/feed/feed_more.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListFeedView extends StatelessWidget {
  final String title;
  final List<MediaBasic> data;
  final FeedMore? more;
  final double width;

  const ListFeedView({
    super.key,
    required this.title,
    required this.data,
    required this.more,
    this.width = 120,
  });

  TextPainter _textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(style: style, text: data.first.title * 10),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 8);

    return textPainter;
  }

  double _calculateListHeight(ThemeData theme) {
    final double height = (width - 8) * (1 / Constants.coverRatio);
    final double textHeight = _textSize(theme.textTheme.bodySmall!).height;
    return height + 26 + textHeight;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return data.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (more != null)
                      IconButton(
                        onPressed: () {
                          context.goNamed(
                            'explore-detail',
                            pathParameters: {
                              'type': more!.type.name,
                              'path': more!.path
                            },
                            queryParameters:
                                more!.options ?? <String, dynamic>{},
                            extra: title,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: _calculateListHeight(theme),
                child: ListView.builder(
                  padding: const EdgeInsets.all(14).copyWith(top: 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CoverCard(
                      media: data[index],
                      width: width,
                    );
                  },
                ),
              )
            ],
          );
  }
}
