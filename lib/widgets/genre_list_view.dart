import 'package:flutter/material.dart';

class GenreListView extends StatelessWidget {
  const GenreListView({
    super.key,
    required this.genres,
    this.height = 48,
  });

  final List<String> genres;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(
              style: theme.outlinedButtonTheme.style!.copyWith(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                ),
              ),
              onPressed: () {},
              child: Text(
                genres[index],
                style: theme.textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }
}
