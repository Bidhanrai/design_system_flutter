import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Loads the Dart grammar and both themes once, then hands out a highlighted
/// [TextSpan] for the active brightness.
class HighlighterService {
  static late final Highlighter _light;
  static late final Highlighter _dark;

  static Future<void> init() async {
    await Highlighter.initialize(['dart']);
    final lightTheme = await HighlighterTheme.loadLightTheme();
    final darkTheme = await HighlighterTheme.loadDarkTheme();
    _light = Highlighter(language: 'dart', theme: lightTheme);
    _dark = Highlighter(language: 'dart', theme: darkTheme);
  }

  static TextSpan highlight(String code, Brightness brightness) {
    final highlighter = brightness == Brightness.dark ? _dark : _light;
    return highlighter.highlight(code);
  }
}
