import 'package:flutter/material.dart';

class ColorConstants {
  static const Color PRIMARY_COLOR = Color(0xff5808e5);
  static const Color PRIMARY_COLOR_DARK = Color(0xFF0D1325);
  static const Color SCAFFOLD_COLOR_DARK = Color(0xFF292929);
  static const Color GREY_COLOR = Color(0xffe0e0e0);
  static const Color GREY_COLOR_2 = Color(0xff9e9e9e);
  static const Color YELLOW_COLOR = Color.fromARGB(234, 241, 220, 23);

  static const Color BOXSHADOW_BG_DARK = Color(0xFF242425);
  static const Color BOXSHADOW_BG_LIGHT = Color(0xffe0e0e0);
  static const Color BOXSHADOW_COLOR_1 = Color(0xFF9E9E9E);
  static const Color BOXSHADOW_COLOR_2 = Color(0xB3FFFFFF);
  static const Color BOXSHADOW_COLOR_DARK_1 = Color(0xFF0F0F0F);
  static const Color BOXSHADOW_COLOR_DARK_2 = Color(0xB31F1E1E);
  static const Color GREY_COLOR_TEXT = Color.fromARGB(255, 97, 97, 97);

  static const Color BLACK_COLOR = Color(0xFF000000);
  static const Color WHITE_COLOR = Color(0xffffffffff);
  static const Color iconColor = Color(0xFFB6C7D1);
  static const Color activeColor = Color(0xFF09126C);
  static const Color textColor1 = Color(0XFFA7BCC7);
  static const Color textColor2 = Color(0XFF9BB3C0);
  static const Color facebookColor = Color(0xFF3B5999);
  static const Color googleColor = Color(0xFFDE4B39);
  static const Color backgroundColor = Color(0xFFECF3F9);
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = const Color(0xFFF6F6F6);
  static Color darkGray = const Color(0xFF9F9F9F);
  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static const Color errorRed = Color(0xFFFF3B30);
  static const Color lightRed = Color(0xFFFF6057);
  static const Color accentBlue = Color(0xFF6BD1E7);
  static const Color accentDarkBlue = Color(0xFF6B9DE7);
  static const Color primary = Color(0xFF6BE7C8);
  static const Color darkBlue = Color(0xff37434d);
  static const Color darkRed = Color(0xff4D3737);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
