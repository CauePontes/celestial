import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dusk => dark.copyWith(
    scaffoldBackgroundColor: const Color(0xFF201A31),
    colorScheme: dark.colorScheme.copyWith(surface: const Color(0xFF302640)),
  );
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Plus Jakarta Sans',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.lavender,
        onSecondary: AppColors.backgroundDeep,
        surface: AppColors.surface,
        surfaceContainerHigh: AppColors.surfaceElevated,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        error: AppColors.danger,
        outline: AppColors.border,
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme
          .copyWith(
            displaySmall: const TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 38,
              height: 1.15,
            ),
            headlineLarge: const TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 32,
              height: 1.2,
            ),
            headlineMedium: const TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 28,
              height: 1.2,
            ),
            titleLarge: const TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 24,
              height: 1.3,
            ),
            bodyLarge: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 17,
              height: 1.5,
            ),
            bodyMedium: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 15,
              height: 1.5,
            ),
            bodySmall: const TextStyle(
              fontSize: 13,
              fontFamily: 'Plus Jakarta Sans',
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          )
          .apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(48, 56),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.lavender),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: AppColors.lavender),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.backgroundDeep,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: AppColors.lavender),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.lavender
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}
