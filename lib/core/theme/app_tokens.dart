import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Semantic design tokens. Every widget reads from these so the whole
/// library restyles and adapts to dark mode from one place.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.primary,
    required this.onPrimary,
    required this.accentWeak,
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.text,
    required this.muted,
    required this.faint,
    required this.codeBg,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
  });

  final Color primary;
  final Color onPrimary;
  final Color accentWeak;
  final Color bg;
  final Color surface;
  final Color surfaceAlt;
  final Color border;
  final Color text;
  final Color muted;
  final Color faint;
  final Color codeBg;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  static const light = AppTokens(
    primary: Color(0xFF5457E5),
    onPrimary: Color(0xFFFFFFFF),
    accentWeak: Color(0xFFECECFB),
    bg: Color(0xFFF6F7F9),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFF0F2F5),
    border: Color(0xFFE3E6EA),
    text: Color(0xFF1A1D21),
    muted: Color(0xFF697079),
    faint: Color(0xFF9AA1A9),
    codeBg: Color(0xFFF7F8FA),
    radiusSm: 7,
    radiusMd: 10,
    radiusLg: 16,
  );

  static const dark = AppTokens(
    primary: Color(0xFF7D80F2),
    onPrimary: Color(0xFF0E1013),
    accentWeak: Color(0xFF1F2140),
    bg: Color(0xFF0E1013),
    surface: Color(0xFF16191D),
    surfaceAlt: Color(0xFF1C2025),
    border: Color(0xFF282D33),
    text: Color(0xFFE7EAED),
    muted: Color(0xFF9AA1A9),
    faint: Color(0xFF6B727A),
    codeBg: Color(0xFF101317),
    radiusSm: 7,
    radiusMd: 10,
    radiusLg: 16,
  );

  @override
  AppTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? accentWeak,
    Color? bg,
    Color? surface,
    Color? surfaceAlt,
    Color? border,
    Color? text,
    Color? muted,
    Color? faint,
    Color? codeBg,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
  }) {
    return AppTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      accentWeak: accentWeak ?? this.accentWeak,
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      border: border ?? this.border,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      codeBg: codeBg ?? this.codeBg,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      accentWeak: Color.lerp(accentWeak, other.accentWeak, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      codeBg: Color.lerp(codeBg, other.codeBg, t)!,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t)!,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t)!,
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t)!,
    );
  }
}

extension AppTokensX on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}
