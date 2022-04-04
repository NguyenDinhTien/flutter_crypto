import 'package:crypto_flutter/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorConstants.PRIMARY_COLOR,
      ),
      primaryColor: ColorConstants.PRIMARY_COLOR,
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: ColorConstants.BLACK_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        subtitle2: TextStyle(
          color: ColorConstants.GREY_COLOR_TEXT,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        headline4: TextStyle(
          color: ColorConstants.GREY_COLOR_TEXT,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ));

  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorConstants.PRIMARY_COLOR_DARK,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorConstants.PRIMARY_COLOR_DARK,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: ColorConstants.WHITE_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        subtitle2: TextStyle(
          color: ColorConstants.WHITE_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        headline4: TextStyle(
          color: ColorConstants.GREY_COLOR_TEXT,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ));
}
