import 'package:flutter/material.dart';

import '../../registry/doc_entry.dart';

class DocPage extends StatelessWidget {
  const DocPage({super.key, required this.doc});

  final DocEntry doc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 26, 32, 60),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Align(
          alignment: Alignment.topLeft,
          child: doc.builder(context),
        ),
      ),
    );
  }
}
