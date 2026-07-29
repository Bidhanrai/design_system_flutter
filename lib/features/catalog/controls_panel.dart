import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../registry/component_entry.dart';
import '../../registry/control.dart';
import 'segmented.dart';

class ControlsPanel extends StatelessWidget {
  const ControlsPanel({
    super.key,
    required this.controls,
    required this.props,
    required this.onChanged,
  });

  final List<Control> controls;
  final PropMap props;
  final void Function(String key, Object value) onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(top: BorderSide(color: t.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CONTROLS',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: t.faint)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 28,
            runSpacing: 16,
            children: [for (final c in controls) _control(context, t, c)],
          ),
        ],
      ),
    );
  }

  Widget _control(BuildContext context, AppTokens t, Control c) {
    final field = switch (c) {
      ChoiceControl() => AppSegmented<String>(
          value: props[c.key] as String,
          options: c.options,
          onChanged: (v) => onChanged(c.key, v),
        ),
      BoolControl() => Switch(
          value: props[c.key] as bool,
          activeThumbColor: t.primary,
          onChanged: (v) => onChanged(c.key, v),
        ),
      SliderControl() => SizedBox(
          width: 220,
          child: Slider(
            value: (props[c.key] as num).toDouble(),
            min: c.min,
            max: c.max,
            divisions: c.divisions,
            activeColor: t.primary,
            onChanged: (v) => onChanged(c.key, v),
          ),
        ),
      ColorControl() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final color in c.options) _swatch(t, c.key, color),
          ],
        ),
    };

    final label = c is SliderControl
        ? '${c.label} — ${(props[c.key] as num).toInt()}px'
        : c.label;

    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: t.muted)),
          const SizedBox(height: 7),
          Align(alignment: Alignment.centerLeft, child: field),
        ],
      ),
    );
  }

  Widget _swatch(AppTokens t, String key, int color) {
    final active = props[key] as int == color;
    return GestureDetector(
      onTap: () => onChanged(key, color),
      child: Container(
        width: 26,
        height: 26,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(t.radiusSm),
          border: Border.all(
            color: active ? t.text : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
