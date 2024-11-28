import 'dart:developer';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/screens/widgets/dashed_line.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class TransactionSuccess extends StatelessWidget {
  TransactionSuccess({super.key});

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const CustomStackWidget(),
          Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Assets.reciept,
                    height: screenHeight * 0.75,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: screenHeight * 0.66,
                      width: screenWidth * 0.80,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.18),
                          Text(
                            LocaleKeys.great.tr(),
                            textAlign: TextAlign.center,
                            style: Styles.regularText.copyWith(
                              color: primaryColor,
                              fontSize: screenHeight * 0.03,
                            ),
                          ),
                          Text(
                            LocaleKeys.depositSuccess.tr(),
                            textAlign: TextAlign.center,
                            style: Styles.regularText.copyWith(
                              color: blackColor,
                              fontSize: screenHeight * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            LocaleKeys.transactionSummary.tr(),
                            textAlign: TextAlign.center,
                            style: Styles.regularText.copyWith(
                              fontSize: screenHeight * 0.016,
                              fontWeight: FontWeight.w400,
                              color: mediumGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.65,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: screenHeight * 0.05,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02),
                                      decoration: const BoxDecoration(
                                        color: tabBarBgColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          LocaleKeys.securelyPaidVia.tr(),
                                          style: Styles.regularText.copyWith(
                                            fontSize: screenHeight * 0.015,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: screenHeight * 0.05,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffE2D8D3),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Image.asset(
                                        Assets.zamaPay,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.1),
                            child: CustomPaint(
                              painter: DashedLinePainter(),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'John Smith',
                                      style: Styles.regularText.copyWith(
                                          color: mediumBlack,
                                          fontSize: screenHeight * 0.016),
                                    ),
                                    TextSpan(
                                      text: '(12345-XXXX XXXX)',
                                      style: Styles.regularText.copyWith(
                                          color: primaryColor,
                                          fontSize: screenHeight * 0.016),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                LocaleKeys.from.tr(),
                                style: Styles.regularText.copyWith(
                                  color: mediumGrey,
                                  fontSize: screenHeight * 0.016,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Sara James',
                                      style: Styles.regularText.copyWith(
                                          color: mediumBlack,
                                          fontSize: screenHeight * 0.016),
                                    ),
                                    TextSpan(
                                      text: '(12345-XXXX XXXX)',
                                      style: Styles.regularText.copyWith(
                                          color: primaryColor,
                                          fontSize: screenHeight * 0.016),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                LocaleKeys.to.tr(),
                                style: Styles.regularText.copyWith(
                                  color: mediumGrey,
                                  fontSize: screenHeight * 0.016,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.date_time.tr(),
                                style: Styles.regularText.copyWith(
                                  color: mediumBlack,
                                  fontSize: screenHeight * 0.016,
                                ),
                              ),
                              Text(
                                'June 3, 2024  10:34 PM',
                                style: Styles.regularText.copyWith(
                                  color: mediumGrey,
                                  fontSize: screenHeight * 0.016,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            LocaleKeys.totalAmount.tr(),
                            textAlign: TextAlign.center,
                            style: Styles.regularText.copyWith(
                              color: mediumGrey,
                              fontSize: screenHeight * 0.016,
                            ),
                          ),
                          Text(
                            '\$50.00',
                            textAlign: TextAlign.center,
                            style: Styles.regularText.copyWith(
                              fontSize: screenHeight * 0.04,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.04,
              ),
              child: CustomButton(
                text: LocaleKeys.back_to_home.tr(),
                onPressed: () {
                  context.goNamed(Routes.homeScreen);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: kToolbarHeight,
                right: screenWidth * 0.04,
              ),
              child: IconButton(
                onPressed: () {
                  screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) {
                    if (context.mounted) {
                      showCapturedWidget(context, capturedImage!);
                    }
                  }).catchError((onError) {
                    log(onError);
                  });
                },
                icon: const Icon(
                  Icons.print,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("TR-012013"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}
