import 'package:flutter/material.dart';

import '../../core/highlight/highlighter_service.dart';
import '../../core/theme/app_tokens.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final brightness = Theme.of(context).brightness;
    final span = HighlighterService.highlight(code, brightness);

    return Container(
      width: double.infinity,
      color: t.codeBg,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText.rich(
          span,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.6),
        ),
      ),
    );
  }
}
