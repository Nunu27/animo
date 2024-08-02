import 'package:animo/domain/entities/filter/filter.dart';
import 'package:animo/presentation/search/widgets/filter_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterRangeWidget extends ConsumerWidget {
  final FilterRange filter;
  const FilterRangeWidget({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title: Text(filter.label),
      children: [
        Row(
          children: [
            Expanded(
              child: FilterInputWidget(
                filter: FilterInput(
                  'From',
                  '${filter.key}Greater',
                ),
              ),
            ),
            Expanded(
              child: FilterInputWidget(
                filter: FilterInput(
                  'To',
                  '${filter.key}Lesser',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
