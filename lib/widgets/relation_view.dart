import 'package:animo/constants/constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelationView extends ConsumerWidget {
  final PaginatedData<BaseData> data;

  const RelationView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getMediaBasicProvider(
          list: data.data,
          source: data.source,
        ))
        .when(
          data: (relations) {
            return relations.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Relations',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      SizedBox(
                        height: 196,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: relations.length,
                          padding: const EdgeInsets.all(8),
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
          loading: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'Relations',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(
                height: 196,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(6),
                      child: AspectRatio(
                        aspectRatio: Constants.coverRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LoadingShimmer(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }
}
