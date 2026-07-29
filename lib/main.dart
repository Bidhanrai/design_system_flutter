import 'package:flutter/material.dart';

import 'app.dart';
import 'core/highlight/highlighter_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HighlighterService.init();
  runApp(const DesignKitApp());
}
