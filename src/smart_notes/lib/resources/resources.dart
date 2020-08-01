import 'package:flutter/material.dart';

class AppImages {
  static const ic_google = '$_rootPath/ic_google.png';
  static const im_empty_note = '$_rootPath/im_empty_note.png';
  static const im_logo_48 = '$_rootPath/im_logo_48.png';
  static const im_logo_128 = '$_rootPath/im_logo_128.png';

  static const _rootPath = 'assets/graphics';
}

class AppColors {
  static const accentPrimary = Color(0xFFFE8c00);
  static const accentSecondary = Color(0xFFF83600);
}

class AppGradients {
  static const orangeAccent = LinearGradient(
    colors: <Color>[
      AppColors.accentPrimary,
      AppColors.accentSecondary,
    ],
  );

  static final lightGray = LinearGradient(
    colors: <Color>[
      Colors.grey[300],
      Colors.grey[200],
    ],
  );
}

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Open Sans',
    brightness: Brightness.light,
    primarySwatch: MaterialColor(
      4294872064,
      {
        50: Color(0xfffff4e5),
        100: Color(0xffffe8cc),
        200: Color(0xffffd199),
        300: Color(0xffffba66),
        400: Color(0xffffa333),
        500: Color(0xffff8d00),
        600: Color(0xffcc7000),
        700: Color(0xff995400),
        800: Color(0xff663800),
        900: Color(0xff331c00)
      },
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
    ),
    colorScheme: ColorScheme(
      primary: Color(0xfffe8c00),
      primaryVariant: Color(0xff995400),
      secondary: Color(0xffff8d00),
      secondaryVariant: Color(0xff995400),
      surface: Color(0xffffffff),
      background: Color(0xffffd199),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xff000000),
      onSecondary: Color(0xff000000),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        height: 1.6,
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      button: TextStyle(
        letterSpacing: 0.4,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.black87,
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Open Sans',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF1c1c1c),
    cardColor: Colors.grey[850],
    primarySwatch: MaterialColor(
      4294872064,
      {
        50: Color(0xfffff4e5),
        100: Color(0xffffe8cc),
        200: Color(0xffffd199),
        300: Color(0xffffba66),
        400: Color(0xffffa333),
        500: Color(0xffff8d00),
        600: Color(0xffcc7000),
        700: Color(0xff995400),
        800: Color(0xff663800),
        900: Color(0xff331c00)
      },
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
    ),
    colorScheme: ColorScheme(
      primary: Color(0xfffe8c00),
      primaryVariant: Color(0xff995400),
      secondary: Color(0xffff8d00),
      secondaryVariant: Color(0xff995400),
      surface: Color(0xffffffff),
      background: Color(0xffffd199),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xff000000),
      onSecondary: Color(0xff000000),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        height: 1.6,
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      button: TextStyle(
        letterSpacing: 0.4,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.white70,
        ),
      ),
    ),
  );
}
