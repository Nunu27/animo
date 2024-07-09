import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/presentation/media/widgets/section_header.dart';
import 'package:animo/presentation/shared/widgets/cards/card_cover.dart';
import 'package:flutter/material.dart';

class RelationView extends StatelessWidget {
  final PaginatedData<MediaBasic> relations;

  const RelationView({
    super.key,
    required this.relations,
  });

  @override
  Widget build(BuildContext context) {
    if (relations.items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          text: 'Relations',
          haveMore: relations.haveNext,
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: relations.items
                .map(
                  (media) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: CoverCard(
                      media: media,
                      onTap: () {},
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
