import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/sticker_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _remember = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      return;
    }
    setState(() => _loading = true);
    // TODO: replace this fake delay with Supabase sign-in
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top bar: logo + theme toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StickerBox(
                      color: p.lime,
                      radius: 30,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.checkroom, size: 18, color: onLime),
                          SizedBox(width: 6),
                          Text(
                            'closet',
                            style: TextStyle(
                              color: onLime,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        appThemeMode.value = isDark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                      },
                      child: StickerBox(
                        radius: 14,
                        padding: const EdgeInsets.all(10),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(
                                turns: Tween(
                                  begin: 0.75,
                                  end: 1.0,
                                ).animate(anim),
                                child: FadeTransition(
                                  opacity: anim,
                                  child: child,
                                ),
                              ),
                          child: Icon(
                            isDark ? Icons.light_mode : Icons.dark_mode,
                            key: ValueKey(isDark),
                            color: p.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Hero
                Text(
                  'Your closet,\nbut make it\ndigital.',
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    color: p.ink,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Log in to see your looks, plans and friends.',
                  style: TextStyle(
                    color: p.ink.withOpacity(0.65),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),

                // Sticker row
                Row(
                  children: [
                    _tiltedSticker(p.lilac, Icons.checkroom, -0.12),
                    _tiltedSticker(p.pink, Icons.watch, 0.10),
                    _tiltedSticker(p.lime, Icons.shopping_bag, -0.06),
                    _tiltedSticker(p.surface, Icons.diamond_outlined, 0.14),
                  ],
                ),
                const SizedBox(height: 28),

                // Fields
                StickerField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 16),
                StickerField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline,
                  obscure: _obscure,
                  suffix: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: p.ink,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'Use at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 14),

                // Remember me + forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _remember = !_remember),
                      child: Row(
                        children: [
                          StickerBox(
                            width: 24,
                            height: 24,
                            radius: 7,
                            shadow: 2,
                            color: _remember ? p.lime : p.surface,
                            child: _remember
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: onLime,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: p.ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: p.pink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                StickerButton(
                  label: 'Log in',
                  loading: _loading,
                  onTap: _login,
                ),
                const SizedBox(height: 24),

                // Social
                Row(
                  children: [
                    Expanded(child: Divider(color: p.ink, thickness: 2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: p.ink.withOpacity(0.65)),
                      ),
                    ),
                    Expanded(child: Divider(color: p.ink, thickness: 2)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: StickerButton(
                        label: 'Google',
                        color: p.surface,
                        textColor: p.ink,
                        leading: Icon(
                          Icons.g_mobiledata,
                          size: 30,
                          color: p.ink,
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StickerButton(
                        label: 'Apple',
                        color: p.surface,
                        textColor: p.ink,
                        leading: Icon(Icons.apple, size: 24, color: p.ink),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New here? ',
                      style: TextStyle(color: p.ink.withOpacity(0.65)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          color: p.pink,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                          decorationColor: p.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tiltedSticker(Color color, IconData icon, double angle) {
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Transform.rotate(
        angle: angle,
        child: StickerBox(
          width: 52,
          height: 52,
          radius: 26,
          color: color,
          child: Icon(icon, color: color == p.surface ? p.ink : onLime),
        ),
      ),
    );
  }
}
