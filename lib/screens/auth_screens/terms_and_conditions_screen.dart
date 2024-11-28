import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import '../../utils/assets_constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Text(
              LocaleKeys.completeActivation.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
            Text(
              LocaleKeys.readAndAcceptLegal.tr(),
              style: Styles.regularText.copyWith(color: mediumGrey),
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'LEGAL INFORMATION: ',
                  style: Styles.regularText.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : blackColor)),
              TextSpan(
                  text: Assets.privacyText,
                  style: Styles.regularText.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: mediumGrey))
            ])),
            const SizedBox(
              height: 25,
            ),
            const Spacer(),
            CustomButton(
                text: LocaleKeys.acceptConditions.tr(),
                onPressed: () {
                  Utils.goTo(context, Routes.activationCompletedScreen);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivationCompleted()));
                }),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
