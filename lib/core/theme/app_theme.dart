import 'package:flutter/material.dart';

import 'app_tokens.dart';

class AppTheme {
  static ThemeData get light => _build(AppTokens.light, Brightness.light);
  static ThemeData get dark => _build(AppTokens.dark, Brightness.dark);

  static ThemeData _build(AppTokens t, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: t.primary,
      brightness: brightness,
    ).copyWith(surface: t.surface);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: t.bg,
      extensions: [t],
    );
  }
}
