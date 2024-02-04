import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_relation.dart';
import 'package:animo/services/api.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationView extends ConsumerWidget {
  const RelationView({
    super.key,
    required this.relationList,
    required this.dataSource,
    required this.slug,
  });

  final List<MediaRelation>? relationList;
  final DataSource dataSource;
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, RelationType> relationMap = relationList == null
        ? {}
        : {
            for (MediaRelation element in relationList!)
              element.id: element.type
          };
    final List<String> slugs = relationList == null
        ? []
        : relationList!.map((mediaRelation) => mediaRelation.id).toList();
    // print('output relationMap : $relationMap');
    return relationList == null
        ? const SizedBox()
        : FutureBuilder(
            future:
                ref.read(apiServiceProvider).getMediaBasics(slugs, dataSource),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final relation = snapshot.data!;
                // print('output snapshot.data : $relation');
                return relation.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Relations',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: relation.length,
                              itemBuilder: (context, index) {
                                return CoverCardCompact(
                                  media: relation[index],
                                );
                              },
                              // Text(relationMap[slug]!.text),
                            ),
                          ),
                        ],
                      );
              } else if (snapshot.hasError) {
                return ErrorView(
                  message: snapshot.error.toString(),
                );
              } else {
                return const SizedBox();
              }
            },
          );
  }
}
