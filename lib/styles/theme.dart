import 'package:bible/styles/colors.dart';
import 'package:flutter/material.dart';

// class AppColors {
class AppColor {
  final bool isDarkMode;

  AppColor({required this.isDarkMode});

  Color get primary => isDarkMode ? primaryD : primaryL;
  Color get secondary => isDarkMode
      ? const Color.fromARGB(122, 71, 147, 114)
      : const Color.fromARGB(115, 71, 147, 114);
  Color get background => isDarkMode
      ? const Color.fromRGBO(28, 24, 24, 1)
      : const Color.fromARGB(255, 37, 134, 102);
  Color get background2 => isDarkMode
      ? const Color.fromRGBO(28, 24, 24, 1)
      : const Color.fromARGB(255, 67, 172, 128);
  Color get textColor =>
      isDarkMode ? backgroundL : const Color.fromARGB(255, 255, 254, 254);
  Color get appBarColor => isDarkMode ? primaryL : primaryD;
  Color get customgrey => isDarkMode ? grey : grey;

  Color get btn2 => isDarkMode
      ? const Color.fromARGB(255, 60, 60, 60)
      : const Color.fromARGB(255, 53, 111, 86);

  Color get grey => isDarkMode
      ? const Color.fromARGB(255, 143, 143, 143)
      : const Color.fromARGB(255, 255, 255, 255);

  Color get searchBarBackground => isDarkMode
      ? const Color.fromARGB(255, 121, 121, 121)
      : const Color.fromARGB(255, 230, 230, 230);
  LinearGradient get gradienttap => isDarkMode
      ? LinearGradient(
          colors: [
            const Color.fromARGB(255, 66, 66, 66),
            const Color.fromARGB(255, 118, 118, 118),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(57, 161, 111, 1),
            Color.fromRGBO(39, 111, 76, 1),
          ],
          stops: [0.0, 1.0],
        );
}
