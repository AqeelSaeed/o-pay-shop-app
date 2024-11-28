import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

import '../../../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Utils.myBackButton(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.forgotPasswordTitle.tr(),
                  style: Styles.appBarThemeStyle(context),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  LocaleKeys.enterPhoneNumberToReset.tr(),
                  style: Styles.regularText.copyWith(color: mediumGrey),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: numberController,
                  prefixIconPath: Assets.phoneIcon,
                  prefixColor: primaryColor,
                  inputType: TextInputType.number,
                  labelText: LocaleKeys.phoneNumber.tr(),
                  hintText: '+1123-456-789',
                ),
                const SizedBox(height: 25),
                CustomButton(
                    text: LocaleKeys.sendOTP.tr(),
                    onPressed: () {
                      sendOtp();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendOtp() {
    // if (numberController.text.isEmpty) {
    //   Utils.showErrorSnack(context, 'Please enter number. ');
    //   return;
    // }
    // String passwordChange = 'true';
    // String imageVerify = 'false';

    // context.go(Uri(path: '/${Routes.otpScreen}/', queryParameters: {
    //   'isPasswordChanged': passwordChange,
    //   'isImageVerification': imageVerify
    // }).toString());

    context.pushNamed(Routes.otpScreen, pathParameters: {
      "isPasswordChanged": "true",
      "isImageVerification": "false",
      "value": "value"
    });

    // Navigator.push(context, MaterialPageRoute(builder: (context)
    // => const OTPScreen(isPasswordChanged: true, isImageVerification: false,)));
  }
}
