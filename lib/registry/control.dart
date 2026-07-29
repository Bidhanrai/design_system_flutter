/// Typed knobs. Each control edits one key in a component's props map, which
/// drives both the live preview and the generated source.
sealed class Control {
  const Control(this.key, this.label, this.defaultValue);

  final String key;
  final String label;
  final Object defaultValue;
}

class ChoiceControl extends Control {
  const ChoiceControl(super.key, super.label, super.defaultValue, this.options);
  final List<String> options;
}

class BoolControl extends Control {
  const BoolControl(super.key, super.label, super.defaultValue);
}

class SliderControl extends Control {
  const SliderControl(
    super.key,
    super.label,
    super.defaultValue, {
    required this.min,
    required this.max,
    this.divisions,
  });
  final double min;
  final double max;
  final int? divisions;
}

class ColorControl extends Control {
  const ColorControl(super.key, super.label, super.defaultValue, this.options);
  final List<int> options;
}
