import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const _accent = Color(0xFF2D5BE3);
  static const _accentDark = Color(0xFF5B82F5);

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _accent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F5F0),
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          bodyColor: const Color(0xFF1A1714),
          displayColor: const Color(0xFF1A1714),
        ),
        extensions: const [AppColors.light],
      );

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _accentDark,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0E0D),
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          bodyColor: const Color(0xFFF0EDE8),
          displayColor: const Color(0xFFF0EDE8),
        ),
        extensions: const [AppColors.dark],
      );
}

/// Custom theme extension — access via Theme.of(context).ext<AppColors>()!
class AppColors extends ThemeExtension<AppColors> {
  final Color accent;
  final Color bg;
  final Color bg2;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color border;
  final Color tagBg;
  final Color tagText;

  const AppColors({
    required this.accent,
    required this.bg,
    required this.bg2,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.border,
    required this.tagBg,
    required this.tagText,
  });

  static const light = AppColors(
    accent: Color(0xFF2D5BE3),
    bg: Color(0xFFF7F5F0),
    bg2: Color(0xFFEDEAE3),
    card: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1A1714),
    textSecondary: Color(0xFF5A5550),
    textHint: Color(0xFF9A928A),
    border: Color(0x14000000),
    tagBg: Color(0xFFE8EDFC),
    tagText: Color(0xFF1A3FA0),
  );

  static const dark = AppColors(
    accent: Color(0xFF5B82F5),
    bg: Color(0xFF0F0E0D),
    bg2: Color(0xFF1A1917),
    card: Color(0xFF1A1917),
    textPrimary: Color(0xFFF0EDE8),
    textSecondary: Color(0xFFA09890),
    textHint: Color(0xFF625C57),
    border: Color(0x12FFFFFF),
    tagBg: Color(0xFF1C2547),
    tagText: Color(0xFF8AAAF8),
  );

  @override
  AppColors copyWith({
    Color? accent,
    Color? bg,
    Color? bg2,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? border,
    Color? tagBg,
    Color? tagText,
  }) =>
      AppColors(
        accent: accent ?? this.accent,
        bg: bg ?? this.bg,
        bg2: bg2 ?? this.bg2,
        card: card ?? this.card,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textHint: textHint ?? this.textHint,
        border: border ?? this.border,
        tagBg: tagBg ?? this.tagBg,
        tagText: tagText ?? this.tagText,
      );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      accent: Color.lerp(accent, other.accent, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      bg2: Color.lerp(bg2, other.bg2, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      border: Color.lerp(border, other.border, t)!,
      tagBg: Color.lerp(tagBg, other.tagBg, t)!,
      tagText: Color.lerp(tagText, other.tagText, t)!,
    );
  }
}
