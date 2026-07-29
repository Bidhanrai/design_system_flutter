# DesignKit — Flutter Web Design System (POC)

A browsable gallery for a custom Flutter widget library: preview widgets and
screen patterns, tune them with live controls, view and copy the generated
Dart, and switch between iOS/Android device frames — with light/dark and a
responsive top-bar + side-menu layout.

## Run it

This repo ships `lib/` and `pubspec.yaml` only. Generate the web platform
folder, then run:

```bash
flutter create . --platforms=web   # regenerates web/ without touching lib/
flutter pub get
flutter run -d chrome
```

Requires a recent Flutter (3.4+). If pub resolution complains about a version,
bump the offending constraint in `pubspec.yaml`.

## What's in Phase 1

- **Widgets:** Button, Tab, Calendar (custom, token-built)
- **Patterns:** Login, OTP Verification, Loading (shown in device frames)
- **Docs:** Getting Started, Theming & Tokens, Using the Gallery
- Preview ⇄ Code toggle, Canvas ⇄ Device (iOS/Android) surface, live Controls,
  copy-to-clipboard, light/dark, responsive drawer on mobile

## Architecture

```
lib/
  main.dart                 init highlighter, run app
  app.dart                  MaterialApp.router + ThemeCubit
  core/
    theme/app_tokens.dart   ThemeExtension design tokens (light/dark)
    theme/app_theme.dart    ThemeData from tokens
    theme/theme_cubit.dart  light/dark state
    router/app_router.dart  GoRouter shell + routes
    highlight/…             syntax_highlight init + highlight()
  registry/
    control.dart            typed knobs (choice/bool/slider/color)
    component_entry.dart     one entry = preview + controls + code + usage
    doc_entry.dart
    registry.dart           the catalog (single source of truth)
  components/               the custom widget library (AppButton, …)
  patterns/                 full-screen patterns (LoginScreen, …)
  features/
    shell/                  top bar (nav on the right), side menu, responsive shell
    catalog/                component page: toolbar, preview surface, code view, controls
    docs/                   doc page
```

**The registry is the core.** Each `ComponentEntry` carries a `builder`
(live preview), typed `controls`, and a `code` generator. The controls drive
both the preview and the regenerated source, so the displayed code never drifts
from the rendered widget — this is the Phase-1 "edit params live" mechanism.

## Packages

- `device_frame_plus` — embedded per-component iOS/Android frames
- `syntax_highlight` — Dart source highlighting (TextMate grammar)
- `go_router` — shell route + deep-linkable component URLs
- `flutter_bloc` — theme state

Note: available `Devices.*` identifiers in `preview_surface.dart` depend on the
installed `device_frame_plus` version; swap them if your catalog differs.

## Phase 2 (not built)

Free-text Dart editing with live preview — via a runtime interpreter
(`dart_eval` / `flutter_eval`) or a DartPad embed. The registry stays
code-as-string and data-driven so this drops in without restructuring.


