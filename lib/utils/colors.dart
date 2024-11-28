import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff7C5946);
const Color splashPaternColor = Color(0xff846250);
const Color primaryLightColor = Color(0xff997B6C);
const Color sliderButtonBGColor = Color(0xffC5B2A8);
const Color secondaryColor = Colors.white;
const Color blackColor = Colors.black;
const Color mediumBlack = Color(0xff2E2E2E);
const Color lightGrey = Color(0xffEBEBEB);
const Color circleBorderColor = Color(0xffEAEAEA);
const Color mediumGrey = Color(0xff9D9D9D);
const Color otpColor = Color(0xffB69F93);
const Color otpTextColor = Color(0xff2E2E2E);
const Color tabBarBgColor = Color(0xffF0EBE9);
const Color hintTextColor = Color(0xff606060);
const Color depositColor = Color(0xff2760D5);
const Color transferColor = Color(0xff691AD0);
const Color withdrawColor = Color(0xff2CC267);
const Color addBankTileBgColor = Color(0xffF9FAFC);
const Color border = Color(0xFFD9D9D9);
//============ Dark Theme Colors ========================
const Color darkTileColor = Color(0xff342B26);
const Color darkScaffoldColor = Color(0xff211E1D);
const Color darkReferenceBgColor = Color(0xff3D332E);

Color getContainerColor(BuildContext context, Color primaryColor) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xff211E1D) // Dark theme color
      : primaryColor; // Light theme color
}

Color getTransactionListColor(BuildContext context, Color color) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xff342B26) // Dark theme color
      : color; // Light theme color
}
