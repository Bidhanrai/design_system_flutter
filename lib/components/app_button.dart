import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

enum AppButtonVariant { filled, tonal, outline, text }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.size = AppButtonSize.md,
    this.radius,
    this.color,
    this.fullWidth = false,
    this.icon,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final double? radius;
  final Color? color;
  final bool fullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = color ?? t.primary;
    final disabled = onPressed == null;
    final r = BorderRadius.circular(radius ?? t.radiusMd);

    final (padding, fontSize) = switch (size) {
      AppButtonSize.sm => (const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 13.0),
      AppButtonSize.md => (const EdgeInsets.symmetric(horizontal: 20, vertical: 11), 14.0),
      AppButtonSize.lg => (const EdgeInsets.symmetric(horizontal: 26, vertical: 14), 15.0),
    };

    final onBase = ThemeData.estimateBrightnessForColor(base) == Brightness.dark
        ? Colors.white
        : Colors.black;

    late final Color bg;
    late final Color fg;
    BorderSide side = BorderSide.none;
    switch (variant) {
      case AppButtonVariant.filled:
        bg = base;
        fg = onBase;
      case AppButtonVariant.tonal:
        bg = base.withValues(alpha: .14);
        fg = base;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = base;
        side = BorderSide(color: base, width: 1.5);
      case AppButtonVariant.text:
        bg = Colors.transparent;
        fg = base;
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: fontSize + 3, color: fg),
          const SizedBox(width: 8),
        ],
        DefaultTextStyle.merge(
          style: TextStyle(color: fg, fontSize: fontSize, fontWeight: FontWeight.w600),
          child: child,
        ),
      ],
    );

    final button = Opacity(
      opacity: disabled ? 0.45 : 1,
      child: Material(
        color: bg,
        borderRadius: r,
        child: InkWell(
          onTap: onPressed,
          borderRadius: r,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(borderRadius: r, border: Border.fromBorderSide(side)),
            child: content,
          ),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
