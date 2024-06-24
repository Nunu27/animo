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
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return colorScheme.primaryContainer;
              } else {
                return colorScheme.surface;
              }
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return colorScheme.onPrimaryContainer;
              } else {
                return colorScheme.onSurface;
              }
            },
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: colorScheme.primaryContainer,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        showDragHandle: true,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        surfaceTintColor: colorScheme.surface,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
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
          foregroundColor: colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
        ),
      ),
      chipTheme: ChipThemeData(
        color: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
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
