import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/auth_screens/forgot_password/forgot_password_screen.dart';

import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/snippets.dart';

import '../../utils/assets_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                LocaleKeys.welcomeBack.tr(),
                style: Styles.appBarThemeStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.signIn.tr(),
                style: Styles.regularTextTheme(context)
                    .copyWith(color: mediumGrey),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: phoneController,
                inputType: TextInputType.phone,
                hintText: LocaleKeys.phoneNumber.tr(),
                labelText: LocaleKeys.phoneNumber.tr(),
                prefixIconPath: Assets.phoneIcon,
                prefixColor: primaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordController,
                inputType: TextInputType.text,
                hintText: LocaleKeys.password.tr(),
                labelText: LocaleKeys.password.tr(),
                prefixIconPath: Assets.lockIcon,
                prefixColor: primaryColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => push(context, const ForgotPasswordScreen()),
                  child: Text(
                    LocaleKeys.forgotPassword.tr(),
                    style: Styles.regularText.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: LocaleKeys.login.tr(),
                  onPressed: () {
                    loginUser();
                  }),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => context.pushNamed(Routes.signupScreen),
                  child: RichText(
                    text: TextSpan(
                        text: LocaleKeys.noAccountSignUp.tr(),
                        style: Styles.regularText.copyWith(color: mediumGrey),
                        children: [
                          TextSpan(
                              text: LocaleKeys.signUp.tr(),
                              style: Styles.regularText.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : primaryColor,
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    // if(phoneController.text.isEmpty && passwordController.text.isEmpty){
    //   Utils.showErrorSnack(context, 'Please Check ');
    //   return;
    // }
    // if(phoneController.text.isEmpty || passwordController.text.isEmpty){p
    //   Utils.showErrorSnack(context, 'Please Check ');
    // }

    context.goNamed(Routes.homeScreen);
  }
}
