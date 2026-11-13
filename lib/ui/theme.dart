import 'package:flutter/material.dart';

/// Calm green & gold palette inspired by Qur'an study circles.
class AppColors {
  AppColors._();

  static const primary = Color(0xFF0F6E5F);
  static const primaryDark = Color(0xFF0A4C42);
  static const primarySoft = Color(0xFFE3F1EE);
  static const gold = Color(0xFFC9A227);
  static const goldSoft = Color(0xFFF7EFD6);
  static const background = Color(0xFFF8F6F1);
  static const surface = Colors.white;
  static const text = Color(0xFF1C2B28);
  static const textMuted = Color(0xFF66756F);
  static const border = Color(0xFFE4E1D8);
  static const success = Color(0xFF15803D);
  static const warning = Color(0xFFD97706);
  static const danger = Color(0xFFDC2626);

  static const headerGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primary, primaryDark],
  );

  static Color forProgress(double p) {
    if (p >= 0.8) return success;
    if (p >= 0.4) return primary;
    return warning;
  }
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.primary, primary: AppColors.primary, secondary: AppColors.gold);
  OutlineInputBorder border(Color c, [double w = 1]) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: c, width: w));

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.text,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary, 1.6),
      errorBorder: border(AppColors.danger),
      focusedErrorBorder: border(AppColors.danger, 1.6),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primarySoft,
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ),
    chipTheme: ChipThemeData(
      side: const BorderSide(color: AppColors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    dividerTheme: const DividerThemeData(color: AppColors.border, space: 1),
  );
}

/// Arabic date formatting without extra dependencies.
class Dates {
  Dates._();

  static const _months = [
    'جانفي', 'فيفري', 'مارس', 'أفريل', 'ماي', 'جوان',
    'جويلية', 'أوت', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  static String day(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

  static String relative(DateTime d, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(d.year, d.month, d.day);
    final diff = target.difference(today).inDays;
    if (diff == 0) return 'اليوم';
    if (diff == 1) return 'غدًا';
    if (diff == -1) return 'أمس';
    if (diff > 1) return 'بعد $diff يوم';
    return 'منذ ${-diff} يوم';
  }

  static String ago(DateTime d, DateTime now) {
    final diff = now.difference(d);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
    return day(d);
  }
}
