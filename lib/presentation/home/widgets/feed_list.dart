import 'package:animo/core/router/app_router.gr.dart';
import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/presentation/shared/widgets/cards/card_cover.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class FeedList extends StatelessWidget {
  final String title;
  final List<MediaBasic> listData;

  const FeedList({super.key, required this.title, required this.listData});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14).copyWith(top: 0),
          child: Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.all(14).copyWith(top: 0),
            scrollDirection: Axis.horizontal,
            itemCount: listData.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return CoverCard(
                media: listData[index],
                onTap: () {
                  context.router.push(
                    MediaDetailRoute(
                      id: listData[index].id,
                      cover: listData[index].cover,
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
