import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../core/theme/app_tokens.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      backgroundColor: t.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Welcome back',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700, color: t.text)),
              const SizedBox(height: 6),
              Text('Sign in to continue',
                  style: TextStyle(color: t.muted, fontSize: 14)),
              const SizedBox(height: 28),
              _field(t, 'Email', Icons.mail_outline),
              const SizedBox(height: 14),
              _field(t, 'Password', Icons.lock_outline, obscure: true),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot password?',
                    style: TextStyle(color: t.primary, fontSize: 12.5, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              AppButton(
                fullWidth: true,
                size: AppButtonSize.lg,
                onPressed: () {},
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text.rich(TextSpan(
                  text: 'New here? ',
                  style: TextStyle(color: t.muted, fontSize: 13),
                  children: [
                    TextSpan(
                        text: 'Create account',
                        style: TextStyle(color: t.primary, fontWeight: FontWeight.w600)),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(AppTokens t, String hint, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: TextStyle(color: t.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: t.faint),
        prefixIcon: Icon(icon, color: t.faint, size: 20),
        filled: true,
        fillColor: t.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radiusMd),
          borderSide: BorderSide(color: t.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radiusMd),
          borderSide: BorderSide(color: t.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(t.radiusMd),
          borderSide: BorderSide(color: t.primary, width: 1.5),
        ),
      ),
    );
  }
}
