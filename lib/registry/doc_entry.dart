import 'package:flutter/widgets.dart';

class DocEntry {
  const DocEntry({required this.id, required this.title, required this.builder});

  final String id;
  final String title;
  final WidgetBuilder builder;
}
