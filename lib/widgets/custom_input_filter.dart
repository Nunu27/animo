import 'package:flutter/material.dart';

class CustomInputFilter extends StatefulWidget {
  const CustomInputFilter({
    super.key,
    required this.optionValue,
    required this.filterKey,
    required this.label,
    this.title,
  });

  final Map<String, dynamic> optionValue;
  final String label;
  final String filterKey;
  final String? title;

  @override
  State<CustomInputFilter> createState() => _CustomInputFilterState();
}

class _CustomInputFilterState extends State<CustomInputFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: widget.optionValue[widget.filterKey],
        onChanged: (value) {
          widget.optionValue[widget.filterKey] = value;
          setState(() {});
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(widget.label),
          hintText: widget.title,
        ),
      ),
    );
  }
}
