import 'package:animo/models/filter/select_option.dart';
import 'package:flutter/material.dart';

class CustomMultiSelect extends StatefulWidget {
  const CustomMultiSelect({
    super.key,
    required this.optionValue,
    required this.filterKey,
    required this.label,
    required this.options,
  });

  final Map<String, dynamic> optionValue;
  final List<SelectOption> options;
  final String label;
  final String filterKey;

  @override
  State<CustomMultiSelect> createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.label),
      children: widget.options
          .map(
            (option) => CheckboxListTile(
              value: widget.optionValue[widget.filterKey]
                      ?.contains(option.value) ??
                  false,
              onChanged: (bool? newValue) {
                if (widget.optionValue[widget.filterKey] == null) {
                  widget.optionValue[widget.filterKey] = [];
                }

                if (newValue ?? false) {
                  widget.optionValue[widget.filterKey].add(option.value);
                } else {
                  widget.optionValue[widget.filterKey].remove(option.value);
                }

                setState(() {});
              },
              title: Text(option.text),
            ),
          )
          .toList(),
    );
  }
}
