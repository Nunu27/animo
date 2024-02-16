import 'package:animo/constants/constants.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:flutter/material.dart';

class CoverCardCompactGridView extends StatelessWidget {
  final List<MediaBasic> data;
  final int column;
  final bool isScrollable;

  const CoverCardCompactGridView({
    super.key,
    required this.data,
    this.column = 2,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: column,
        childAspectRatio: Constants.coverRatio,
        children: data
            .map(
              (e) => CoverCardCompact(
                media: e,
              ),
            )
            .toList());
  }
}
