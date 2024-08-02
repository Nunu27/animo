import 'package:animo/core/mixins/filter_mixin.dart';
import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/presentation/search/widgets/filter_view.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final MediaType type;
  final List<Filter> filters;
  const FilterModal({
    super.key,
    required this.type,
    required this.filters,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> with FilterMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.filters.map(
          (e) => FilterView(filter: e),
        ),
      ],
    );
  }
}
