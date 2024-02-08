import 'package:animo/constants/constants.dart';
import 'package:animo/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          imageUrl: getProxyUrl(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
