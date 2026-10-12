import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class StickerBox extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double shadow;

  const StickerBox({
    super.key,
    required this.child,
    this.color,
    this.radius = 16,
    this.padding,
    this.width,
    this.height,
    this.shadow = 4,
  });

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? p.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: p.ink, width: 2),
        boxShadow: [BoxShadow(color: p.shadow, offset: Offset(shadow, shadow))],
      ),
      child: child,
    );
  }
}

class StickerButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final Widget? leading;
  final bool loading;

  const StickerButton({
    super.key,
    required this.label,
    this.onTap,
    this.color,
    this.textColor,
    this.leading,
    this.loading = false,
  });

  @override
  State<StickerButton> createState() => _StickerButtonState();
}

class _StickerButtonState extends State<StickerButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fill = widget.color ?? p.lime;
    final textColor = widget.textColor ?? onLime;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.loading
          ? null
          : () {
              HapticFeedback.lightImpact();
              widget.onTap?.call();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        height: 56,
        transform: Matrix4.translationValues(
          _pressed ? 3 : 0,
          _pressed ? 3 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: p.ink, width: 2),
          boxShadow: [
            BoxShadow(
              color: p.shadow,
              offset: _pressed ? const Offset(1, 1) : const Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: widget.loading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: textColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class StickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const StickerField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);

    OutlineInputBorder border(Color c, [double w = 2]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: c, width: w),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: p.pink,
      style: TextStyle(color: p.ink, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: p.ink.withOpacity(0.6)),
        floatingLabelStyle: TextStyle(
          color: p.pink,
          fontWeight: FontWeight.w700,
        ),
        prefixIcon: Icon(icon, color: p.ink),
        suffixIcon: suffix,
        filled: true,
        fillColor: p.surface,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        enabledBorder: border(p.ink),
        focusedBorder: border(p.pink, 2.5),
        errorBorder: border(Colors.redAccent),
        focusedErrorBorder: border(Colors.redAccent, 2.5),
      ),
    );
  }
}
