import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/presentation/media/widgets/section_header.dart';
import 'package:animo/presentation/shared/widgets/loading_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({
    super.key,
    this.imgPlaceholder =
        'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
    required this.characters,
  });

  final String imgPlaceholder;
  final PaginatedData<CharacterBasic> characters;

  @override
  Widget build(BuildContext context) {
    if (characters.items.isEmpty) return const SizedBox();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          text: 'Characters',
          haveMore: characters.haveNext,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 145,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: characters.items.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final character = characters.items[index];
              return Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: character.cover ?? imgPlaceholder,
                          placeholder: (context, url) => const LoadingShimmer(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      character.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium!.copyWith(height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      character.role.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
