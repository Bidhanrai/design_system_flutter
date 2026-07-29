import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';

class AppSegmented<T> extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.labelOf,
  });

  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T)? labelOf;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        border: Border.all(color: t.border),
        borderRadius: BorderRadius.circular(t.radiusSm + 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final o in options) _segment(t, o),
        ],
      ),
    );
  }

  Widget _segment(AppTokens t, T o) {
    final active = o == value;
    final label = labelOf?.call(o) ?? '$o';
    // return GestureDetector(
    return InkWell(
      onTap: () => onChanged(o),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        // duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: active ? t.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(t.radiusSm - 1),
          boxShadow: active
              ? [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 3)]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: active ? t.text : t.muted,
          ),
        ),
      ),
    );
  }
}
