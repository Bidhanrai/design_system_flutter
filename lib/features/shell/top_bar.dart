import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_cubit.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.section,
    required this.wide,
    required this.onMenu,
  });

  final String section;
  final bool wide;
  final VoidCallback onMenu;

  static const _nav = [
    ('widgets', 'Widgets', '/widgets/button'),
    ('patterns', 'Patterns', '/patterns/login'),
    ('docs', 'Documentation', '/docs/start'),
  ];

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      child: Row(
        children: [
          if (!wide)
            IconButton(
              onPressed: onMenu,
              icon: Icon(Icons.menu, color: t.text),
            ),
          _brand(t),
          const Spacer(),
          if (wide) ...[
            for (final item in _nav) _navButton(context, t, item),
            const SizedBox(width: 8),
          ],
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => context.read<ThemeCubit>().toggle(),
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: t.muted, size: 20),
          ),
          // IconButton(
          //   tooltip: 'Repository',
          //   onPressed: () {},
          //   icon: Icon(Icons.open_in_new, color: t.muted, size: 18),
          // ),
        ],
      ),
    );
  }

  Widget _brand(AppTokens t) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [t.primary, const Color(0xFF8B8DF5)]),
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: const Text('D',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
        ),
        const SizedBox(width: 9),
        Text('DesignKit',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5, color: t.text)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(color: t.border),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('v0.1', style: TextStyle(fontSize: 11, color: t.muted)),
        ),
      ],
    );
  }

  Widget _navButton(BuildContext context, AppTokens t, (String, String, String) item) {
    final active = item.$1 == section;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: TextButton(
        onPressed: () => context.go(item.$3),
        style: TextButton.styleFrom(
          foregroundColor: active ? t.primary : t.muted,
          backgroundColor: active ? t.accentWeak : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        ),
        child: Text(item.$2),
      ),
    );
  }
}
