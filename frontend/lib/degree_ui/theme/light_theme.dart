import 'package:degree_app/degree_ui/degree_ui.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.grey,
  fontFamily: 'Gilroy',
  textTheme: const TextTheme(
    headline4: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    subtitle2: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(
        const Color(0xFFF6F6F6),
      ),
      fixedSize: MaterialStateProperty.all(
        const Size(double.infinity, 46),
      ),
      shadowColor: MaterialStateProperty.all(Colors.white),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(14),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      side: MaterialStateProperty.all(
        const BorderSide(),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(const Color(0xFF292929)),
      fixedSize: MaterialStateProperty.all(const Size(double.infinity, 46)),
      shadowColor: MaterialStateProperty.all(Colors.white),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
);
