import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_tokens.dart';
import '../../registry/component_entry.dart';
import 'code_view.dart';
import 'preview_surface.dart';
import 'segmented.dart';

class ComponentPage extends StatefulWidget {
  const ComponentPage({super.key, required this.entry});

  final ComponentEntry entry;

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  late PropMap _props;
  String _view = 'preview';
  late PreviewMode _mode;
  String _os = 'ios';

  @override
  void initState() {
    super.initState();
    _props = Map.of(widget.entry.defaults());
    _mode = widget.entry.defaultMode;
  }

  // void _set(String key, Object value) => setState(() => _props[key] = value);

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.entry.code(_props)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
        width: 200,
      ));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final entry = widget.entry;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 26, 32, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                        color: t.text)),
                const SizedBox(height: 6),
                Text(entry.description,
                    style: TextStyle(fontSize: 14.5, color: t.muted, height: 1.5)),
                const SizedBox(height: 20),
                _card(t, entry),
                const SizedBox(height: 20),
                _usage(t, entry),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(AppTokens t, ComponentEntry entry) {
    return Container(
      decoration: BoxDecoration(
        color: t.surface,
        border: Border.all(color: t.border),
        borderRadius: BorderRadius.circular(t.radiusMd),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _toolbar(t),
          Divider(height: 1, color: t.border),
          if (_view == 'preview')
            PreviewSurface(entry: entry, props: _props, mode: _mode, os: _os)
          else
            CodeView(code: entry.code(_props)),
            //TODO
          // if (entry.controls.isNotEmpty)
          //   ControlsPanel(controls: entry.controls, props: _props, onChanged: _set),
        ],
      ),
    );
  }

  Widget _toolbar(AppTokens t) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          AppSegmented<String>(
            value: _view,
            options: const ['preview', 'code'],
            labelOf: (v) => v == 'preview' ? 'Preview' : 'Code',
            onChanged: (v) => setState(() => _view = v),
          ),
          const Spacer(),
          ///TODO:
          // AppSegmented<PreviewMode>(
          //   value: _mode,
          //   options: PreviewMode.values,
          //   labelOf: (m) => m == PreviewMode.canvas ? 'Canvas' : 'Device',
          //   onChanged: (m) => setState(() => _mode = m),
          // ),
          if (_mode == PreviewMode.device) ...[
            const SizedBox(width: 8),
            AppSegmented<String>(
              value: _os,
              options: const ['ios', 'android'],
              labelOf: (v) => v == 'ios' ? 'iOS' : 'Android',
              onChanged: (v) => setState(() => _os = v),
            ),
          ],
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: _copy,
            icon: const Icon(Icons.copy_rounded, size: 15),
            label: const Text('Copy'),
            style: OutlinedButton.styleFrom(
              foregroundColor: t.muted,
              side: BorderSide(color: t.border),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _usage(AppTokens t, ComponentEntry entry) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border.all(color: t.border),
        borderRadius: BorderRadius.circular(t.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('How to use',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: t.text)),
          const SizedBox(height: 10),
          Text(entry.usage,
              style: TextStyle(fontSize: 14, color: t.muted, height: 1.55)),
          const SizedBox(height: 8),
          Text('Configure it with the controls above, then switch to the Code tab and copy.',
              style: TextStyle(fontSize: 14, color: t.muted, height: 1.55)),
        ],
      ),
    );
  }
}
