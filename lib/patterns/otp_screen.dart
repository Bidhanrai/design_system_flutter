import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../core/theme/app_tokens.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, this.length = 4, this.filled = 2});

  final int length;
  final int filled;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Verify your number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: t.text)),
              const SizedBox(height: 8),
              Text('Enter the code sent to +977 ••• ••• 21',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: t.muted, fontSize: 13)),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < length; i++) _box(t, i),
                ],
              ),
              const SizedBox(height: 28),
              AppButton(
                fullWidth: true,
                size: AppButtonSize.lg,
                onPressed: () {},
                child: const Text('Verify'),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text('Resend in 0:24',
                    style: TextStyle(color: t.muted, fontSize: 12.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(AppTokens t, int i) {
    final isFilled = i < filled;
    return Container(
      width: 48,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(t.radiusMd),
        border: Border.all(color: isFilled ? t.primary : t.border, width: 1.5),
      ),
      child: Text(
        isFilled ? '${4 - i}' : '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: t.primary),
      ),
    );
  }
}
