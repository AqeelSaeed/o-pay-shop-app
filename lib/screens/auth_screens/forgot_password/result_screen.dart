import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';

import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class ResultScreen extends StatelessWidget {
  final String isPasswordChanged;
  final String isImageVerified;
  const ResultScreen(
      {super.key,
      required this.isImageVerified,
      required this.isPasswordChanged});

  @override
  Widget build(BuildContext context) {
    log('isImageVerified: $isImageVerified');
    log('isPasswordChanged: $isPasswordChanged');
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            const CustomStackWidget(),
            isPasswordChanged == 'true'
                ? resultContainer(
                    context,
                    LocaleKeys.passwordChanged.tr(),
                    LocaleKeys.passwordChangedSuccess.tr(),
                    LocaleKeys.login.tr())
                : resultContainer(
                    context,
                    '${LocaleKeys.welcome.tr()} John Smith',
                    '${LocaleKeys.accountValidated.tr()}. John*****@gmail.com',
                    LocaleKeys.activateAccount.tr())
          ],
        ),
      ),
    );
  }

  resultContainer(context, title, bodyText, buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isPasswordChanged == 'true'
              ? Image.asset(
                  Assets.successPng,
                  height: 134,
                )
              : SizedBox(
                  height: 134,
                  width: 134,
                  child: Stack(
                    children: [
                      Image.asset(Assets.greenCircle),
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            Assets.greenEmail,
                            height: 75,
                            width: 75,
                          )),
                    ],
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: Styles.appBarTextStyle.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            bodyText,
            style: Styles.regularText.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: buttonText,
              onPressed: () {
                if (isPasswordChanged == 'true') {
                  Utils.navigateBack(context, Routes.loginScreen);
                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  //     const LoginScreen()), (Route<dynamic> route) => false);
                } else {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditions()));
                  Utils.goTo(context, Routes.termsAndConditionsScreen);
                }
              })
        ],
      ),
    );
  }
}
