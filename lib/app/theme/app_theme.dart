import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.lavender,
        onSecondary: AppColors.backgroundDeep,
        surface: AppColors.surface,
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
              fontFamily: 'serif',
              fontSize: 38,
              height: 1.15,
            ),
            headlineLarge: const TextStyle(
              fontFamily: 'serif',
              fontSize: 32,
              height: 1.2,
            ),
            headlineMedium: const TextStyle(
              fontFamily: 'serif',
              fontSize: 28,
              height: 1.2,
            ),
            titleLarge: const TextStyle(
              fontFamily: 'serif',
              fontSize: 24,
              height: 1.3,
            ),
            bodyLarge: const TextStyle(fontSize: 16, height: 1.5),
            bodyMedium: const TextStyle(fontSize: 15, height: 1.5),
            bodySmall: const TextStyle(
              fontSize: 13,
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
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(48, 56),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.backgroundDeep,
        indicatorColor: AppColors.surfaceElevated,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: AppColors.lavender),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border),
    );
  }
}
