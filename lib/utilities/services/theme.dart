import 'package:flutter/material.dart';

class ThemeService {
  static final ThemeService _theme = ThemeService._internal();
  factory ThemeService() {
    return _theme;
  }
  ThemeService._internal();

  static const borderRadiusValue = 20.0;

  static const headlineFont = "Quicksand";
  static const bodyFont = "Helvetica";
  static const eventColor = Color.fromARGB(255, 72, 98, 132);
  static const clubColor = Color(0xFF87CEFA);
  static const postColor = Color(0xFF454E5E);
  static const placeColor = Color(0xFF8A2BE2);
  static const friendColor = Color(0xFF3CB371);
  static const unusedColor = Color.fromARGB(255, 182, 182, 182);
  static const disabledColor = Color.fromARGB(255, 215, 215, 215);
  static const background = Colors.white;
  static const menuBackground = Color.fromARGB(255, 255, 255, 255);
  static const textField = Color.fromARGB(255, 240, 240, 240);
  static const primaryText = Colors.black;
  static const secondaryText = Colors.black54;
  static const onContrastColor = Colors.white;

  RoundedRectangleBorder get shape => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusValue));

  static BorderRadius get allAroundBorderRadius =>
      BorderRadius.circular(borderRadiusValue);

  static BorderRadius get fullScreenBorderRadius =>
      const BorderRadius.vertical(bottom: Radius.circular(borderRadiusValue));

  static BorderRadius get mapBorderRadius =>
      const BorderRadius.vertical(top: Radius.circular(borderRadiusValue));

  static List<BoxShadow> get defaultBoxShadow =>
      const [BoxShadow(blurRadius: 5, spreadRadius: 2, color: Colors.black12)];
  
  static EdgeInsets get defaultPadding => const EdgeInsets.all(5);

  static EdgeInsets get defaultMargin => const EdgeInsets.all(5);

  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: eventColor,
      fontFamily: bodyFont,
      colorScheme: const ColorScheme.light(
        primary: eventColor,
        secondary: clubColor,
        onSecondary: primaryText,
        onPrimary: primaryText,
        error: Colors.red,
        onError: primaryText,
        background: background
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: primaryText
        ),
        bodyMedium: TextStyle(
            color: primaryText
        ),
        bodyLarge: TextStyle(
            color: primaryText
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: menuBackground,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: primaryText, fontFamily: headlineFont),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: eventColor,
          disabledColor: unusedColor,
          shape: ThemeService().shape),
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: ButtonStyle(
      //
      //   )
      // ),
      disabledColor: unusedColor,
      drawerTheme: DrawerThemeData(
        backgroundColor: menuBackground,
        shape: ThemeService().shape,
      ));
}
