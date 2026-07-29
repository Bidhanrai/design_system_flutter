import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import 'side_menu.dart';
import 'top_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final segments = state.uri.pathSegments;
    final section = segments.isNotEmpty ? segments.first : 'widgets';
    final id = segments.length > 1 ? segments[1] : '';
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(child: SafeArea(child: SideMenu(section: section, currentId: id))),
      body: Column(
        children: [
          Builder(
            builder: (ctx) => TopBar(
              section: section,
              wide: wide,
              onMenu: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          Expanded(
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 248,
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: t.border)),
                        ),
                        child: SideMenu(section: section, currentId: id),
                      ),
                      Expanded(child: child),
                    ],
                  )
                : child,
          ),
        ],
      ),
    );
  }
}
