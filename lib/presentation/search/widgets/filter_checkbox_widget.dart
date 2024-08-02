import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterCheckboxWidget extends ConsumerWidget {
  final FilterCheckbox filter;

  const FilterCheckboxWidget({
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
        false;

    return ListTile(
      leading: Checkbox(
        value: value,
        onChanged: (_) {
          ref.read(filterStateProvider.notifier).set(filter.key, !value);
        },
      ),
      title: Text(filter.label),
      onTap: () {
        ref.read(filterStateProvider.notifier).set(filter.key, !value);
      },
    );
  }
}
