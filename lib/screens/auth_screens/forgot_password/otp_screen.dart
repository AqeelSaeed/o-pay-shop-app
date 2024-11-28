import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_numeric_keyboard.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';

import '../../../states/otp_timer_provider.dart';
import '../../../styles/styles.dart';
import '../../../utils/utils.dart';
import '../../widgets/otp_input_widget.dart';

class OTPScreen extends StatefulWidget {
  final String isImageVerification;
  final String isPasswordChanged;
  final String? value;
  const OTPScreen(
      {super.key,
      this.value,
      required this.isImageVerification,
      required this.isPasswordChanged});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OTPTimeProvider>().startTimer();
    _focus1.requestFocus();
    _focus1.addListener(() => _onFocusChange(_focus1));
    _focus2.addListener(() => _onFocusChange(_focus2));
    _focus3.addListener(() => _onFocusChange(_focus3));
    _focus4.addListener(() => _onFocusChange(_focus4));
  }

  @override
  void dispose() {
    _focus1.dispose();
    _focus2.dispose();
    _focus3.dispose();
    _focus4.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();

    super.dispose();
  }

  void _onFocusChange(FocusNode focusNode) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = Provider.of<OTPTimeProvider>(context).remainingTime;
    log('device height: ${MediaQuery.of(context).size.height}');
    log('value: ${widget.value}');
    return Scaffold(
      body: Stack(
        children: [
          const CustomStackWidget(),
          Positioned(
            top: kToolbarHeight,
            left: 10,
            child: Utils.myBackButton(context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Expanded(child: centerWidget(remainingTime))],
                ),
              ),
              // Numeric Keypad
              Expanded(
                child: NumericKeypad(
                  controllers: [
                    controller1,
                    controller2,
                    controller3,
                    controller4
                  ],
                  focusNodes: [_focus1, _focus2, _focus3, _focus4],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget centerWidget(remainingTime) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.verifyCode.tr(),
                  style: Styles.appBarTextStyle.copyWith(color: Colors.white),
                ),
                Text(
                  LocaleKeys.enterVerificationCode.tr(),
                  style: Styles.regularText.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          // OTP Input Fields
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OTPInputWidget(
                        controller: controller1,
                        focusNode: _focus1,
                        nextFocus: _focus2,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OTPInputWidget(
                        controller: controller2,
                        focusNode: _focus2,
                        nextFocus: _focus3,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OTPInputWidget(
                        controller: controller3,
                        focusNode: _focus3,
                        nextFocus: _focus4,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OTPInputWidget(
                        controller: controller4,
                        focusNode: _focus4,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<OTPTimeProvider>(
                      builder: (context, time, child) {
                    return RichText(
                      text: TextSpan(
                        text: '${LocaleKeys.resentCodeIn.tr()} ',
                        style: Styles.regularText
                            .copyWith(color: const Color(0xffE2D8D3)),
                        children: [
                          TextSpan(
                            text: formatDuration(remainingTime),
                            style: Styles.regularText.copyWith(
                                color: const Color(0xffE2D8D3),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 28),
                  child: CustomButton(
                      text: LocaleKeys.continueKey.tr(),
                      onPressed: () {
                        goToNextScreen();
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void goToNextScreen() {
    if (controller1.text.isEmpty &&
        controller2.text.isEmpty &&
        controller3.text.isEmpty &&
        controller4.text.isEmpty) {
      Utils.showErrorSnack(context, 'Invalid OTP');
      return;
    }
    if (controller1.text.isEmpty ||
        controller2.text.isEmpty ||
        controller3.text.isEmpty ||
        controller4.text.isEmpty) {
      Utils.showErrorSnack(context, 'Invalid OTP');
      return;
    }
    context.read<OTPTimeProvider>().timer!.cancel();
    if (widget.isImageVerification == 'true') {
      log('imageVerificatin');
      context.pushNamed(Routes.resultScreen, pathParameters: {
        "isImageVerified": 'true',
        "isPasswordChanged": "false"
      });
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultScreen(
      //   isImageVerified: true,
      //   isPasswordChanged: false,
      // )));
    } else if (widget.isPasswordChanged == 'true') {
      log('password');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPasswordScreen()));
      context.pushNamed(Routes.newPasswordScreen);
    } else if (widget.value == 'deposit') {
      context.push(Routes.transactionSuccess);
    }
  }
}
