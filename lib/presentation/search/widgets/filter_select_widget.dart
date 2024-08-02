import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSelectWidget extends ConsumerStatefulWidget {
  final FilterSelect filter;

  const FilterSelectWidget({
    super.key,
    required this.filter,
  });

  @override
  ConsumerState<FilterSelectWidget> createState() => _FilterSelectWidgetState();
}

class _FilterSelectWidgetState extends ConsumerState<FilterSelectWidget> {
  late final TextEditingController _dropdownController;

  @override
  void initState() {
    super.initState();
    _dropdownController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(
      filterStateProvider.select(
        (options) => options[widget.filter.key],
      ),
    );

    if (value == null) _dropdownController.text = '';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownMenu<String>(
        controller: _dropdownController,
        expandedInsets: EdgeInsets.zero,
        initialSelection: value ?? '',
        dropdownMenuEntries: [
          const DropdownMenuEntry(value: '', label: 'Any'),
          ...widget.filter.options.entries.map(
            (e) => DropdownMenuEntry(value: e.key, label: e.value),
          )
        ],
        label: Text(widget.filter.label),
        onSelected: (value) {
          ref
              .read(filterStateProvider.notifier)
              .set(widget.filter.key, (value?.isEmpty ?? true) ? null : value);
        },
      ),
    );
  }
}
