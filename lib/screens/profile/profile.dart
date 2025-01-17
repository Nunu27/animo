import 'package:animo/widgets/not_login_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animo/controllers/auth_controller.dart';
import 'package:animo/providers/user_provider.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  void logout(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signOut(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: user != null
            ? [
                IconButton(
                  onPressed: () {
                    return logout(ref, context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: theme.colorScheme.error,
                  ),
                ),
              ]
            : null,
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: user.avatar == null
                            ? CircleAvatar(
                                backgroundColor:
                                    theme.colorScheme.secondaryContainer,
                                backgroundImage: const AssetImage(
                                  'assets/images/adaptive-icon.png',
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  user.avatar!,
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            user.email,
                            style: theme.textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const NotLoginView(),
    );
  }
}
