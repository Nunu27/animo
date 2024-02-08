import 'package:animo/models/base_data.dart';
import 'package:animo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FilterModal extends ConsumerStatefulWidget {
  const FilterModal({
    super.key,
    required this.options,
    required this.mediaType,
  });

  final MediaType mediaType;
  final Map<String, dynamic> options;

  @override
  ConsumerState<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends ConsumerState<FilterModal> {
  late Map<String, dynamic> currentOptions =
      Map<String, dynamic>.from(widget.options);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: MultiSliver(
        children: [
          SliverPinnedHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentOptions = {};
                        });
                      },
                      style: theme.textButtonTheme.style!.copyWith(
                        foregroundColor: MaterialStatePropertyAll(
                          theme.colorScheme.primary,
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.pop(currentOptions);
                      },
                      child: const Text('Filter'),
                    )
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          SliverClip(
            child: MultiSliver(
              children: getProviderInfo(widget.mediaType)
                  .mediaFilters
                  .map((e) => e.build(currentOptions))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
