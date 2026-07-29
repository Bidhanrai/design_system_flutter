import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../registry/component_entry.dart';

class PreviewSurface extends StatelessWidget {
  const PreviewSurface({
    super.key,
    required this.entry,
    required this.props,
    required this.mode,
    required this.os,
  });

  final ComponentEntry entry;
  final PropMap props;
  final PreviewMode mode;
  final String os;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final child = entry.builder(context, props);

    // if (mode == PreviewMode.canvas) {
    //   return _stage(t, height: 320, child: Center(child: child));
    //   // return _canvasStage(
    //   //   t,
    //   //   height: 320,
    //   //   child: Center(child: child),
    //   // );
    // }

    final device =
        os == 'ios' ? Devices.ios.iPhone13 : Devices.android.samsungGalaxyS20;

    final screen = entry.fullScreen
        ? child
        : Scaffold(
            appBar: AppBar(title: Text(entry.title), centerTitle: false),
            body: Center(child: child),
          );

    return _stage(
      t,
      height: 640,
      child: FittedBox(
        fit: BoxFit.contain,
        child: DeviceFrame(
          device: device,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: screen,
        ),
      ),
    );
  }

  // Widget _canvasStage(AppTokens t, {required double height, required Widget child}) {
  //   return Container(
  //     width: double.infinity,
  //     constraints: BoxConstraints(minHeight: height),
  //     color: t.surface,
  //     alignment: Alignment.center,
  //     child: Padding(padding: const EdgeInsets.all(24), child: child),
  //   );
  // }

  Widget _stage(AppTokens t, {required double height, required Widget child}) {
    return Container(
      width: double.infinity,
      height: height,
      color: t.surface,
      alignment: Alignment.center,
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    );
  }
}
