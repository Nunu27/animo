import 'package:animo/models/base_data.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationView extends ConsumerWidget {
  final PaginatedData<BaseData>? data;

  const RelationView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return data == null
        ? const SizedBox()
        : ref
            .watch(getMediaBasicProvider(
              list: data!.data,
              source: data!.source,
            ))
            .when(
              data: (relations) {
                return relations.isEmpty
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
                              itemCount: relations.length,
                              itemBuilder: (context, index) {
                                return CoverCardCompact(
                                  media: relations[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
              },
              error: (error, stackTrace) => ErrorView(
                message: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
