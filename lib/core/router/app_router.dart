import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/catalog/component_page.dart';
import '../../features/docs/doc_page.dart';
import '../../features/shell/app_shell.dart';
import '../../registry/registry.dart';

final appRouter = GoRouter(
  initialLocation: '/widgets/button',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(state: state, child: child),
      routes: [
        GoRoute(
          path: '/:section(widgets|patterns)/:id',
          pageBuilder: (context, state) {
            final section = state.pathParameters['section']!;
            final entry =
                Registry.component(section, state.pathParameters['id']!);
            return platformPage(
              context: context,
              state: state,
              child: ComponentPage(
                key: ValueKey('$section-${entry.id}'),
                entry: entry,
              ),
            );
          },
        ),
        GoRoute(
          path: '/docs/:id',
          pageBuilder: (context, state) {
            final doc = Registry.doc(state.pathParameters['id']!);
            return platformPage(
                context: context,
                state: state,
                child: DocPage(key: ValueKey('docs-${doc.id}'), doc: doc));
          },
        ),
      ],
    ),
  ],
);

Page<T> platformPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  String? name,
}) {
  if (kIsWeb) {
    // Web: instant, no transition
    return NoTransitionPage<T>(
      key: state.pageKey,
      name: name ?? state.name ?? state.fullPath,
      child: child,
    );
  }

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    // iOS: Cupertino slide + swipe-back gesture
    return CupertinoPage<T>(
      key: state.pageKey,
      name: name ?? state.name ?? state.fullPath,
      child: child,
    );
  }

  // Android + desktop: Material default (fade-through)
  return MaterialPage<T>(
    key: state.pageKey,
    name: name ?? state.name ?? state.fullPath,
    child: child,
  );
}
