import 'package:animo/constants/constants.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:flutter/material.dart';

class CoverCardCompactGridView extends StatelessWidget {
  const CoverCardCompactGridView({
    super.key,
    required this.data,
    this.physics,
    this.column = 2,
    this.shrinkWrap = false,
  });

  final List<MediaBasic> data;
  final int column;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: column,
      physics: physics,
      shrinkWrap: shrinkWrap,
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
