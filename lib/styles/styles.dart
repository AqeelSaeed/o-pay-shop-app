import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

abstract class Styles {
  static const appBarTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: blackColor);

  static TextStyle appBarThemeStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white // For dark theme
          : Colors.black, // For light theme
    );
  }

  static const regularText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: blackColor,
  );

  static TextStyle regularMediumBlackStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white // For dark theme
          : mediumBlack, // For light theme
    );
  }

  static TextStyle regularTextTheme(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white // For dark theme
          : Colors.black, // For light theme
    );
  }

  static const navItemStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: blackColor,
  );

  static const transactionItemStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: blackColor);

  static TextStyle getTransactionItemStyle(BuildContext context) {
    // Define colors based on the theme
    Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white // White text for dark theme
        : Colors.black; // Black text for light theme

    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: textColor, // Set color based on the theme
    );
  }
}
