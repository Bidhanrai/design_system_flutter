import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message = 'Loading…', this.showSkeleton = true});

  final String message;
  final bool showSkeleton;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showSkeleton) ...[
                _bar(t, widthFactor: 0.6, height: 18),
                _bar(t),
                _bar(t, widthFactor: 0.92),
                _bar(t, widthFactor: 0.8),
                const SizedBox(height: 28),
              ],
              const Spacer(),
              Center(child: CircularProgressIndicator(color: t.primary)),
              const SizedBox(height: 16),
              Center(child: Text(message, style: TextStyle(color: t.muted, fontSize: 13))),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bar(AppTokens t, {double widthFactor = 1, double height = 14}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          height: height,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: t.surfaceAlt,
            borderRadius: BorderRadius.circular(t.radiusSm),
          ),
        ),
      ),
    );
  }
}
