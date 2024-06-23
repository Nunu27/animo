import 'package:flutter/material.dart';

class AnimoTheme {
  const AnimoTheme({required this.colorScheme});

  final ColorScheme colorScheme;

  ThemeData build() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'PlusJakartaSans',
      segmentedButtonTheme: SegmentedButtonThemeData(
        selectedIcon: null,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return colorScheme.primaryContainer;
              } else {
                return colorScheme.background;
              }
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return colorScheme.onPrimaryContainer;
              } else {
                return colorScheme.onBackground;
              }
            },
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: colorScheme.primaryContainer,
        iconTheme: MaterialStatePropertyAll(
          IconThemeData(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.background,
        surfaceTintColor: colorScheme.background,
        showDragHandle: true,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        surfaceTintColor: colorScheme.background,
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onBackground,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onBackground,
        ),
      ),
      chipTheme: ChipThemeData(
        color: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primaryContainer;
          }

          return null;
        }),
        shape: StadiumBorder(
          side: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}
