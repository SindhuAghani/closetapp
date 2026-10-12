import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.light);

const onLime = Color(0xFF14111F);

class Palette {
  final Color bg;
  final Color surface;
  final Color ink;
  final Color shadow;
  final Color lime;
  final Color pink;
  final Color lilac;

  const Palette({
    required this.bg,
    required this.surface,
    required this.ink,
    required this.shadow,
    required this.lime,
    required this.pink,
    required this.lilac,
  });

  static const light = Palette(
    bg: Color(0xFFF4F1FF),
    surface: Colors.white,
    ink: Color(0xFF14111F),
    shadow: Color(0xFF14111F),
    lime: Color(0xFFC8FF3D),
    pink: Color(0xFFFF4D8D),
    lilac: Color(0xFFB69CFF),
  );

  static const dark = Palette(
    bg: Color(0xFF0F0D17),
    surface: Color(0xFF1C1829),
    ink: Color(0xFFF5F2FF),
    shadow: Color(0xFFB69CFF),
    lime: Color(0xFFC8FF3D),
    pink: Color(0xFFFF4D8D),
    lilac: Color(0xFFB69CFF),
  );

  static Palette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.dark ? Palette.dark : Palette.light;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: p.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: p.lilac,
      brightness: brightness,
    ),
  );
}
