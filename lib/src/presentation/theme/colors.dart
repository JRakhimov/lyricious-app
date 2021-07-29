import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color shimmerBase = Color(0xFF373737);
  static const Color shimmerHighlight = Color(0xFF4A4A4A);

  static const Color grey = Color(0xFF6F6F6F);
  static const Color grey6F = Color(0xFF6F6F6F);
  static const Color greyBD = Color(0xFFBDBDBD);
  static const Color greyCF = Color(0xFFCFCFCF);
  static const Color greyEA = Color(0xFFEAEAEA);
  static const Color greyF0 = Color(0xFFF0F0F0);
  static const Color greyF9 = Color(0xFFF9F9F9);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color red = Color(0xFFD04137);
  static const Color blue = Color(0xFF7492FE);
  static const Color green = Color(0xFF22BD59);
  static const Color violet = Color(0xFF877ADB);
  static const Color yellow = Color(0xFFD4AB2E);
  static const Color pink = Color(0xFFFF6D9E);

  static const Color primary = Color(0xFFECA301);

  static const Color background = Color(0xFF2E2E2E);
  static const Color drawerBackground = Color(0xFF1A1A1A);
  static const Color disabledBackground = Color(0xFF262626);

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static const colors = [
    // indigo,
    red,
    yellow,
    green,
    // orange,
    blue,
    // purple,
    // teal,
    pink,
  ];

  static Color getRandomColor() {
    final random = Random();

    return colors[random.nextInt(5)];
  }
}
