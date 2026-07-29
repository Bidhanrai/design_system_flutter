import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    this.scrollable = false,
    this.onChanged,
  });

  final List<String> tabs;
  final bool scrollable;
  final ValueChanged<int>? onChanged;

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    final row = Row(
      mainAxisSize: widget.scrollable ? MainAxisSize.min : MainAxisSize.max,
      children: [
        for (var i = 0; i < widget.tabs.length; i++)
          _tab(t, i, widget.tabs[i]),
      ],
    );

    final bar = Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      child: widget.scrollable
          ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: row)
          : row,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: bar,
    );
  }

  Widget _tab(AppTokens t, int i, String label) {
    final active = i == _index;
    final tab = InkWell(
      onTap: () {
        setState(() => _index = i);
        widget.onChanged?.call(i);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? t.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? t.primary : t.muted,
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
      ),
    );
    return widget.scrollable ? tab : Expanded(child: Center(child: tab));
  }
}
