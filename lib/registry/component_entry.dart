import 'package:flutter/widgets.dart';

import 'control.dart';

enum Section { widgets, patterns }

enum PreviewMode { canvas, device }

typedef PropMap = Map<String, Object>;

///one entry = preview + controls + code + usage
class ComponentEntry {
  const ComponentEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.section,
    required this.builder,
    required this.code,
    required this.usage,
    this.controls = const [],
    this.isNew = false,
    this.fullScreen = false,
    // this.defaultMode = PreviewMode.canvas,
    this.defaultMode = PreviewMode.device,
  });

  final String id;
  final String title;
  final String description;
  final Section section;
  final Widget Function(BuildContext context, PropMap props) builder;
  final String Function(PropMap props) code;
  final String usage;
  final List<Control> controls;
  final bool isNew;
  final bool fullScreen;
  final PreviewMode defaultMode;

  PropMap defaults() => {for (final c in controls) c.key: c.defaultValue};
}
