import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConstants {
  static int fontSizeMedium = 14;
  static int fontSizelarge = 18;
  static int fontSizeSmall = 12;

  static FontWeight fontWeightThin = FontWeight.w300;
  static FontWeight fontWeightBold = FontWeight.w500;
  static FontWeight fontWeightHeavyBold = FontWeight.w700;

  static LinearGradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0xff3088C6),
      Color(0xff1556BE),
    ],
  );

  static TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle selectedTextStyle = const TextStyle(
      color: Colors.teal, fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle montserratTextStyleSmall = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle montserrattextstyle = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle montserrattextstyle2 = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle montserrattextstyle3 = GoogleFonts.montserrat(
    color: bluecolor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static getTextStyle(bool sizechange) {
    return GoogleFonts.montserrat(
        color: TextColor,
        fontSize: sizechange == false ? 16 : 12,
        fontWeight: FontWeight.w600);
  }

  static Color selectedColor = const Color(0xff4ac8ae);
  static Color drawerBackgroundColor = const Color(0xff272d34);
  static Color bluecolor = const Color(0xFF1940B3);
  static Color whitecolor = const Color(0xFFFFFFFF);
  static Color blackcolor = const Color(0xFF0c0c0c);
  static Color lightgreycolor = const Color(0xFFD3D3D3);
  static Color bluegreycolor = const Color(0xFF525863);
  static Color bluelightgreycolor = const Color(0xFF525863);
  static Color lightVioletColor = const Color(0xFFF6F6FF);
  static Color VioletColor = const Color(0xFF6366F1);
  static Color midVioltetColor = const Color(0xFFEAECFD);
  static Color lightgreentColor = const Color(0xFFF4FDF8);
  static Color lightblueColor = const Color(0xFFF1F4FB);
  static Color lightblueColor2 = Color.fromARGB(255, 218, 229, 255);

  static Color lightorangeColor = const Color(0xFFFFF7F1);
  static Color orangeColor = const Color(0xFFF97316);
  static Color TextColor = const Color(0xFF677082);
  static Color IconColor = const Color(0xFF3C4351);
  static Color GreenColor = const Color(0xFF2FAF5E);
  static Color ultraLightgreyColor = const Color(0xFFF6F6F6);
  static Color lightYellow = const Color(0xFFFFEFD8);
  static Color paleYellow = const Color(0xFFFFF385);

  static Color lightSkyblue = const Color(0xFFe7fbfc);
  static Color lightbrow = const Color(0xFFfbefde);
  static Color browcolor = const Color(0xFFBC7B1D);
  static Color lightRed = const Color(0xFFffe2e2);
  static Color red = const Color(0xFFcf3b3b);
  static Color yellow = const Color.fromARGB(255, 241, 164, 55);
  static Color skycolor = const Color.fromARGB(255, 36, 197, 206);
  static Color bluelightgreycolor2 = const Color.fromARGB(255, 164, 178, 202);
  static Color Lightcian = const Color(0xFFE9FEFF);
  static Color cianColor = const Color(0xFF0EB0B5);
  static Color firstColor = const Color(0xffff9900);




  static List<String> randomTexts = [
    "Please wait..",
    "Gearing up for productivity! 🚀",
    "Syncing agendas for a meeting of the minds! 🧠📝",
    "Fueling up for fruitful discussions! 🍇💬",
    "Gathering thoughts for a collaborative session!",
  ];
  static String backgroundTexts = "";
  static String setBackgroundTexts() {
    final random = Random();
    final randomIndex = random.nextInt(randomTexts.length);
    backgroundTexts = randomTexts[randomIndex];
    return backgroundTexts;
  }
}
