import 'package:animo/constants/constants.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:flutter/material.dart';

class CoverCardCompactGridView extends StatelessWidget {
  const CoverCardCompactGridView({
    super.key,
    required this.data,
    this.column = 2,
  });

  final List<MediaBasic> data;
  final int column;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: column,
      childAspectRatio: Constants.coverRatio,
      children: data
          .map(
            (e) => CoverCardCompact(
              media: e,
            ),
          )
          .toList(),
    );
  }
}
