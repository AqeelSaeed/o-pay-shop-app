import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white, // Light theme background
  appBarTheme: const AppBarTheme(
    color: Colors.white, // AppBar background for light theme
    iconTheme: IconThemeData(color: Colors.black), // Back button icon
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: const IconThemeData(
      size: 30,
      color: primaryColor,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 30,
      color: Colors.grey,
    ),
    selectedLabelStyle: Styles.navItemStyle.copyWith(color: primaryColor),
    unselectedLabelStyle:
        Styles.navItemStyle.copyWith(color: const Color(0xffA1A1A1)),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black), // Black text color
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black), // For AppBar title
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerHeight: 0,
    unselectedLabelColor: mediumBlack,
    unselectedLabelStyle: Styles.regularText.copyWith(
      fontWeight: FontWeight.w500,
    ),
    labelStyle: Styles.regularText
        .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
    indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: primaryColor),
    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    indicatorColor: primaryColor,
  ),
  radioTheme: const RadioThemeData(
    fillColor:
        WidgetStatePropertyAll(primaryColor), // Customize radio button color
  ),
);
