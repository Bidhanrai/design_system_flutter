import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../components/app_calendar.dart';
import '../components/app_tab_bar.dart';
import '../core/theme/app_tokens.dart';
import '../patterns/loading_view.dart';
import '../patterns/login_screen.dart';
import '../patterns/otp_screen.dart';
import 'component_entry.dart';
import 'control.dart';
import 'doc_entry.dart';

///the catalog (single source of truth)
class Registry {
  static final List<ComponentEntry> widgets = [_button, _tab];
  static final List<ComponentEntry> patterns = [_login, _otp, _loading];
  static final List<DocEntry> docs = [_gettingStarted, _theming, _usingGallery];

  static List<ComponentEntry> componentsFor(String section) =>
      section == 'patterns' ? patterns : widgets;

  static ComponentEntry component(String section, String id) {
    final list = componentsFor(section);
    return list.firstWhere((e) => e.id == id, orElse: () => list.first);
  }

  static DocEntry doc(String id) =>
      docs.firstWhere((e) => e.id == id, orElse: () => docs.first);
}

// ---------- widgets ----------

const _tabLabels = ['Overview', 'Activity', 'Settings', 'Profile', 'More'];

final _button = ComponentEntry(
  id: 'button',
  title: 'Button',
  description:
      'A pressable action built from your design tokens. Variants, sizing, and radius all derive from the theme.',
  section: Section.widgets,
  isNew: true,
  controls: const [
    ChoiceControl('variant', 'Variant', 'filled', ['filled', 'tonal', 'outline', 'text']),
    ChoiceControl('size', 'Size', 'md', ['sm', 'md', 'lg']),
    SliderControl('radius', 'Corner radius', 10.0, min: 0, max: 24, divisions: 24),
    ColorControl('color', 'Accent color', 0xFF5457E5,
        [0xFF5457E5, 0xFF2E9E6B, 0xFFE5484D, 0xFFE08A00, 0xFF1A1D21]),
    BoolControl('full', 'Full width', false),
    BoolControl('icon', 'Leading icon', false),
    BoolControl('disabled', 'Disabled', false),
  ],
  builder: (context, p) => AppButton(
    variant: AppButtonVariant.values.byName(p['variant'] as String),
    size: AppButtonSize.values.byName(p['size'] as String),
    radius: (p['radius'] as num).toDouble(),
    color: Color(p['color'] as int),
    fullWidth: p['full'] as bool,
    icon: (p['icon'] as bool) ? Icons.star_rounded : null,
    onPressed: (p['disabled'] as bool) ? null : () {},
    child: const Text('Continue'),
  ),
  code: (p) {
    final radius = (p['radius'] as num).toInt();
    final hex = (p['color'] as int).toRadixString(16).toUpperCase().padLeft(8, '0');
    final iconLine = (p['icon'] as bool) ? '\n  icon: Icons.star_rounded,' : '';
    final onPressed = (p['disabled'] as bool) ? 'null' : '() {}';
    return '''AppButton(
  variant: AppButtonVariant.${p['variant']},
  size: AppButtonSize.${p['size']},
  radius: $radius,
  color: const Color(0x$hex),
  fullWidth: ${p['full']},$iconLine
  onPressed: $onPressed,
  child: const Text('Continue'),
)''';
  },
  usage:
      'Drop AppButton anywhere in your widget tree. Colors come from AppTheme, so it adapts to light and dark automatically.',
);

final _tab = ComponentEntry(
  id: 'tab',
  title: 'Tab',
  description:
      'Segmented navigation between related views. Fixed or scrollable, with a themed indicator.',
  section: Section.widgets,
  controls: const [
    ChoiceControl('count', 'Tabs', '3', ['3', '4', '5']),
    BoolControl('scrollable', 'Scrollable', false),
  ],
  builder: (context, p) {
    final count = int.parse(p['count'] as String);
    return AppTabBar(
      tabs: _tabLabels.take(count).toList(),
      scrollable: p['scrollable'] as bool,
      onChanged: (_) {},
    );
  },
  code: (p) {
    final count = int.parse(p['count'] as String);
    final tabs = _tabLabels.take(count).map((t) => "'$t'").join(', ');
    return '''AppTabBar(
  tabs: [$tabs],
  scrollable: ${p['scrollable']},
  onChanged: (index) {},
)''';
  },
  usage:
      'AppTabBar holds its own selection state and reports changes through onChanged.',
);

final _calendar = ComponentEntry(
  id: 'calendar',
  title: 'Calendar',
  description:
      'A month view with single-date selection, driven by your color and radius tokens.',
  section: Section.widgets,
  controls: const [
    ColorControl('color', 'Accent color', 0xFF5457E5,
        [0xFF5457E5, 0xFF2E9E6B, 0xFFE5484D, 0xFFE08A00]),
  ],
  builder: (context, p) => AppCalendar(
    initialMonth: DateTime(2026, 6),
    selected: DateTime(2026, 6, 14),
    accent: Color(p['color'] as int),
    onSelect: (_) {},
  ),
  code: (p) {
    final hex = (p['color'] as int).toRadixString(16).toUpperCase().padLeft(8, '0');
    return '''AppCalendar(
  initialMonth: DateTime(2026, 6),
  selected: DateTime(2026, 6, 14),
  accent: const Color(0x$hex),
  onSelect: (date) {},
)''';
  },
  usage: 'AppCalendar tracks the selected day and emits it through onSelect.',
);

// ---------- patterns ----------

final _login = ComponentEntry(
  id: 'login',
  title: 'Login',
  description: 'A full sign-in screen pattern, ready to drop into a flow.',
  section: Section.patterns,
  fullScreen: true,
  defaultMode: PreviewMode.device,
  builder: (context, p) => const LoginScreen(),
  code: (p) => '''LoginScreen(
  onSubmit: (email, password) {},
  onForgot: () {},
)''',
  usage: 'Compose the screen from AppButton and themed fields; wire the callbacks to your auth logic.',
);

final _otp = ComponentEntry(
  id: 'otp',
  title: 'OTP Verification',
  description: 'A one-time-code entry screen with individual digit fields.',
  section: Section.patterns,
  fullScreen: true,
  defaultMode: PreviewMode.device,
  builder: (context, p) => const OtpScreen(),
  code: (p) => '''OtpScreen(
  length: 4,
  onComplete: (code) {},
)''',
  usage: 'OtpScreen reports the full code once every field is filled.',
);

final _loading = ComponentEntry(
  id: 'loading',
  title: 'Loading',
  description: 'Loading and skeleton states for content-in-flight.',
  section: Section.patterns,
  fullScreen: true,
  defaultMode: PreviewMode.device,
  builder: (context, p) => const LoadingView(),
  code: (p) => '''LoadingView(
  message: 'Loading…',
  showSkeleton: true,
)''',
  usage: 'Swap LoadingView in while data resolves, then replace it with your content.',
);

// ---------- docs ----------

final _gettingStarted = DocEntry(
  id: 'start',
  title: 'Getting Started',
  builder: (context) => const _Doc(
    title: 'Getting Started',
    blocks: [
      _P('DesignKit is a custom Flutter widget library with a browsable gallery. Preview any widget or screen pattern, tune it live, and copy production-ready Dart.'),
      _H('Install'),
      _P('Add the package to pubspec.yaml, then wrap your app in AppTheme. Pick a component from the left to see it in action.'),
      _H('Three things to know'),
      _P('1. Every widget is built from shared design tokens — one source of truth for color, spacing, and radius.'),
      _P('2. Light and dark are automatic; nothing hard-codes a color.'),
      _P('3. The gallery is the documentation — what you preview is what you ship.'),
    ],
  ),
);

final _theming = DocEntry(
  id: 'theming',
  title: 'Theming & Tokens',
  builder: (context) => const _Doc(
    title: 'Theming & Tokens',
    blocks: [
      _P('Design tokens are named values — primary, radius.md, space.4 — defined once and reused everywhere.'),
      _H('Why tokens'),
      _P('Because widgets reference token names instead of raw values, changing the theme or flipping to dark mode updates the whole library at once, with zero per-widget edits. That is what keeps a custom library consistent as it grows.'),
    ],
  ),
);

final _usingGallery = DocEntry(
  id: 'usage-site',
  title: 'Using the Gallery',
  builder: (context) => const _Doc(
    title: 'Using the Gallery',
    blocks: [
      _H('Layout'),
      _P('The top menu switches sections (Widgets, Patterns, Documentation). The left menu lists items in that section.'),
      _P('Each page has a Preview / Code toggle, a Canvas / Device switch with iOS and Android frames, live Controls, and Copy.'),
    ],
  ),
);

// ---------- doc rendering helpers ----------

class _Doc extends StatelessWidget {
  const _Doc({required this.title, required this.blocks});
  final String title;
  final List<Widget> blocks;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w700, color: t.text, letterSpacing: -0.4)),
        const SizedBox(height: 18),
        ...blocks,
      ],
    );
  }
}

class _H extends StatelessWidget {
  const _H(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: t.text)),
    );
  }
}

class _P extends StatelessWidget {
  const _P(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 14.5, height: 1.6, color: t.muted)),
    );
  }
}
