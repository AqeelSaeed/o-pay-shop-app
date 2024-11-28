import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff211E1D),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white,
    selectedIconTheme: const IconThemeData(
      size: 30,
      color: Colors.black,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 30,
      color: Colors.white,
    ),
    selectedLabelStyle: Styles.navItemStyle.copyWith(color: primaryColor),
    unselectedLabelStyle:
        Styles.navItemStyle.copyWith(color: const Color(0xffA1A1A1)),
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerHeight: 0,
    unselectedLabelColor: Colors.white,
    labelStyle: Styles.regularText
        .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
    indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: primaryColor),
    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    indicatorColor: primaryColor,
    unselectedLabelStyle: Styles.regularText
        .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
  ),
  radioTheme: RadioThemeData(
    overlayColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.all(Colors.white),
  ),
);
