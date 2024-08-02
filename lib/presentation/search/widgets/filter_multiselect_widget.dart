import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterMultiSelectWidget extends ConsumerWidget {
  final FilterMultiSelect filter;

  const FilterMultiSelectWidget({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(
          filterStateProvider.select(
            (options) => options[filter.key],
          ),
        ) ??
        [];

    return ExpansionTile(
      title: Text(filter.label),
      children: filter.options.entries
          .map(
            (option) => CheckboxListTile(
              value: value.contains(option.key),
              onChanged: (bool? newValue) {
                if (newValue ?? false) {
                  value.add(option.key);
                } else {
                  value.remove(option.key);
                }

                ref
                    .read(filterStateProvider.notifier)
                    .set(filter.key, List.of(value));
              },
              title: Text(option.value),
            ),
          )
          .toList(),
    );
  }
}
