import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

import '../../../utils/assets_constants.dart';
import '../../../utils/utils.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Utils.myBackButton(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.newPassword.tr(),
                    style: Styles.appBarThemeStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocaleKeys.createSafePassword.tr(),
                    style: Styles.regularText.copyWith(color: mediumGrey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    controller: newPasswordController,
                    prefixIconPath: Assets.lockIcon,
                    prefixColor: primaryColor,
                    inputType: TextInputType.text,
                    hintText: LocaleKeys.password.tr(),
                    labelText: LocaleKeys.newPassword.tr(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: confirmNewPasswordController,
                    prefixIconPath: Assets.lockIcon,
                    inputType: TextInputType.text,
                    hintText: LocaleKeys.password.tr(),
                    prefixColor: primaryColor,
                    labelText: LocaleKeys.confirm_new_password.tr(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: LocaleKeys.confirm_new_password.tr(),
                      onPressed: () {
                        resetPassword();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword() {
    // if (newPasswordController.text.isEmpty &&
    //     confirmNewPasswordController.text.isEmpty) {
    //   Utils.showErrorSnack(context, 'Please fill the form. ');
    //   return;
    // }
    // if (newPasswordController.text.isEmpty ||
    //     confirmNewPasswordController.text.isEmpty) {
    //   Utils.showErrorSnack(context, 'Please fill the form. ');
    // }
    context.goNamed(Routes.resultScreen, pathParameters: {
      "isPasswordChanged": true.toString(),
      "isImageVerified": false.toString()
    });
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultScreen(
    //   isPasswordChanged: true,
    //   isImageVerified: false,
    // )));
  }
}
