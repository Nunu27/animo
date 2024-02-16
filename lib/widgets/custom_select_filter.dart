import 'package:animo/models/filter/select_option.dart';
import 'package:flutter/material.dart';

class CustomSelectFilter extends StatefulWidget {
  const CustomSelectFilter({
    super.key,
    required this.filterKey,
    required this.label,
    required this.optionValue,
    required this.options,
  });

  final Map<String, dynamic> optionValue;
  final List<SelectOption> options;
  final String label;
  final String filterKey;

  @override
  State<CustomSelectFilter> createState() => _CustomSelectFilterState();
}

class _CustomSelectFilterState extends State<CustomSelectFilter> {
  late SelectOption current = widget.options.firstWhere(
    (element) =>
        widget.optionValue[element.key ?? widget.filterKey] == element.value,
    orElse: () => widget.options.first,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownMenu(
        expandedInsets: EdgeInsets.zero,
        initialSelection: current,
        dropdownMenuEntries: widget.options
            .map((e) => DropdownMenuEntry(value: e, label: e.text))
            .toList(),
        label: Text(widget.label),
        onSelected: (value) {
          if (value == null) return;

          widget.optionValue.remove(current.key ?? widget.filterKey);
          current = value;
          widget.optionValue[current.key ?? widget.filterKey] = current.value;
          setState(() {});
        },
      ),
    );
  }
}
