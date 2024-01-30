import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({
    super.key,
    this.height = 138,
    this.imgPlaceholder =
        'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
    required this.characters,
  });

  final double height;
  final String imgPlaceholder;
  final PaginatedData<MediaCharacter>? characters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (characters != null) {
      return SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: characters!.data.length,
          itemBuilder: (context, index) {
            final character = characters!.data[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: 100,
              child: Column(
                children: [
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        character.cover ?? imgPlaceholder,
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
                    style: theme.textTheme.labelLarge,
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
      );
    } else {
      return const SizedBox();
    }
  }
}
