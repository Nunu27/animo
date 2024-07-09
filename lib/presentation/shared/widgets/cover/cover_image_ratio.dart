import 'package:animo/core/constants/constants.dart';
import 'package:animo/presentation/shared/widgets/cover/cover_image.dart';
import 'package:flutter/material.dart';

class CoverImageRatio extends StatelessWidget {
  const CoverImageRatio({
    super.key,
    this.imageUrl,
    this.coverRatio = Constants.coverRatio,
  });

  final String? imageUrl;
  final double coverRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: coverRatio,
      child: CoverImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
