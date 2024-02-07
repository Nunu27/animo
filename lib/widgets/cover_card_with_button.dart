import 'package:animo/constants/constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/widgets/cover_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoverCardWithText extends StatelessWidget {
  const CoverCardWithText({
    super.key,
    required this.media,
    required this.title,
    required this.sortBy,
    required this.mediatype,
    this.width = 120,
  });

  final PaginatedData<MediaBasic> media;
  final MediaType mediatype;
  final String title;
  final double width;
  final String sortBy;

  TextPainter _textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(style: style, text: media.data.first.title * 10),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width - 8);

    return textPainter;
  }

  double _calculateListHeight(ThemeData theme) {
    final double height = (width - 8) * (1 / Constants.coverRatio);
    final double textHeight = _textSize(theme.textTheme.bodySmall!).height;
    return height + 4 + 8 + textHeight;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            IconButton(
              onPressed: () {
                context.goNamed(
                  'explore-detail',
                  pathParameters: {
                    'media': mediatype.name,
                    'filter': sortBy,
                  },
                  extra: title,
                );
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        SizedBox(
          height: _calculateListHeight(theme),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return CoverCard(
                media: media.data[index],
                width: width,
              );
            },
          ),
        )
      ],
    );
  }
}
