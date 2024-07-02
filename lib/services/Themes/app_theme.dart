import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static const String blueTheme = 'blue';
  static const String redTheme = 'red';

  static final ThemeData blue = ThemeData(
    primaryColor: commonBlueColor,
    dialogBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      color: commonBlueColor,
      foregroundColor: AppColors.white,
      titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    ),
    useMaterial3: false,

    scaffoldBackgroundColor: Color.fromARGB(255, 241, 240, 240),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: mutedBlueColor,
    brightness: Brightness.light,
    highlightColor: textBlueColor,
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //     backgroundColor: Colors.black,
    //     focusColor: Colors.blueAccent,
    //     splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );

  static final ThemeData red = ThemeData(
    dialogBackgroundColor: AppColors.white,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.white,
    ),
    primaryColor: commonRedColor,
    scaffoldBackgroundColor: Color.fromARGB(255, 241, 240, 240),
    appBarTheme: const AppBarTheme(
      color: commonRedColor,
      foregroundColor: AppColors.white,
    ),
    // useMaterial3: true,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: mutedRedColor,
    brightness: Brightness.light,
    highlightColor: textRedColor,
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //     backgroundColor: Colors.black,
    //     focusColor: Colors.blueAccent,
    //     splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );

  static ThemeData getThemeFromKey(String themeKey) {
    switch (themeKey) {
      case blueTheme:
        return blue;
      case redTheme:
        return red;
      default:
        return blue;
    }
  }
}
