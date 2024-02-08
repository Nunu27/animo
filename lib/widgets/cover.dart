import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:animo/constants/constants.dart';

class Cover extends StatelessWidget {
  final String imageUrl;

  const Cover({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Constants.coverRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
