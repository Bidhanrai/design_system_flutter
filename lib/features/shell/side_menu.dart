import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import '../../registry/registry.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.section, required this.currentId});

  final String section;
  final String currentId;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final items = _items();

    return Container(
      color: t.surface,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
            child: Text(
              _sectionTitle().toUpperCase(),
              style: TextStyle(
                // fontSize: 11,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                // color: t.faint,
                color: t.text,
              ),
            ),
          ),
          for (final it in items) _tile(context, t, it),
        ],
      ),
    );
  }

  String _sectionTitle() => switch (section) {
        'patterns' => 'Patterns',
        'docs' => 'Documentation',
        _ => 'Widgets',
      };

  List<({String id, String title, bool isNew})> _items() {
    if (section == 'docs') {
      return Registry.docs.map((d) => (id: d.id, title: d.title, isNew: false)).toList();
    }
    return Registry.componentsFor(section)
        .map((e) => (id: e.id, title: e.title, isNew: e.isNew))
        .toList();
  }

  Widget _tile(BuildContext context, AppTokens t, ({String id, String title, bool isNew}) it) {
    final active = it.id == currentId;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, left: 10),
      child: Material(
        color: active ? t.accentWeak : Colors.transparent,
        borderRadius: BorderRadius.circular(t.radiusSm + 1),
        child: InkWell(
          borderRadius: BorderRadius.circular(t.radiusSm + 1),
          onTap: () => context.go('/$section/${it.id}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              children: [
                Expanded(
                  child: Text(it.title,
                      style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                          color: active ? t.primary : t.muted)),
                ),
                if (it.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: t.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('New',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w700, color: t.onPrimary)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
