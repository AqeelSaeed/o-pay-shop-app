import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: '',
        leadingAsset: Assets.backButton,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.changePassword.tr(),
              style: Styles.appBarThemeStyle(context),
              textAlign: TextAlign.left,
            ),
            Text(
              LocaleKeys.enter_current_and_new_passwords.tr(),
              style: Styles.regularTextTheme(context),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: oldPasswordController,
              prefixIconPath: Assets.lockIcon,
              prefixColor: primaryColor,
              hintText: LocaleKeys.password.tr(),
              labelText: LocaleKeys.old_password.tr(),
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: newPasswordController,
              prefixIconPath: Assets.lockIcon,
              prefixColor: primaryColor,
              hintText: LocaleKeys.password.tr(),
              obscureText: true,
              labelText: LocaleKeys.newPassword.tr(),
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: confirmPasswordController,
              prefixIconPath: Assets.lockIcon,
              prefixColor: primaryColor,
              hintText: LocaleKeys.password.tr(),
              obscureText: true,
              labelText: LocaleKeys.confirm_new_password.tr(),
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 38,
            ),
            CustomButton(
                text: LocaleKeys.confirm_new_password.tr(),
                onPressed: () {
                  changePassword();
                })
          ],
        ),
      ),
    );
  }

  changePassword() {
    if (oldPasswordController.text.isEmpty &&
        newPasswordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
      Utils.showErrorSnack(context, 'All fields are required');
      return;
    }

    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Utils.showErrorSnack(context, 'All fields are required');
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Utils.showErrorSnack(context, 'Both new passwords don\'t match');
      return;
    }
    Utils.showSuccessSnack(context, 'Password Changed Successfully');
  }
}
