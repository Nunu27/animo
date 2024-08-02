import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterInputWidget extends ConsumerWidget {
  final FilterInput filter;

  const FilterInputWidget({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(
      filterStateProvider.select(
        (options) => options[filter.key],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: value,
        onChanged: (newValue) {
          ref.read(filterStateProvider.notifier).set(
                filter.key,
                newValue,
              );
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(filter.label),
        ),
      ),
    );
  }
}
