import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class MakeTransferScreen extends StatefulWidget {
  // final String typeOfFunds;
  const MakeTransferScreen({
    super.key,
  });

  @override
  State<MakeTransferScreen> createState() => _MakeTransferScreenState();
}

class _MakeTransferScreenState extends State<MakeTransferScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              LocaleKeys.makeTransfer.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
            Text(
              LocaleKeys.enableAgents.tr(),
              style: Styles.regularText.copyWith(color: mediumGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                labelText: LocaleKeys.firstName.tr(),
                inputType: TextInputType.text,
                hintText: LocaleKeys.firstName.tr(),
                prefixColor: primaryColor,
                controller: firstNameController,
                prefixIconPath: Assets.userIcon),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: LocaleKeys.lastName.tr(),
                inputType: TextInputType.text,
                hintText: LocaleKeys.lastName.tr(),
                prefixColor: primaryColor,
                controller: lastNameController,
                prefixIconPath: Assets.userIcon),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                labelText: LocaleKeys.account_number.tr(),
                inputType: TextInputType.number,
                hintText: '12345-6789-1012',
                prefixColor: primaryColor,
                inputLimit: 16,
                controller: accountNumberController,
                prefixIconPath: Assets.cardIcon),
            const Spacer(),
            CustomButton(
                text: LocaleKeys.next.tr(),
                onPressed: () {
                  // if (firstNameController.text.isEmpty &&
                  //     lastNameController.text.isEmpty &&
                  //     accountNumberController.text.isEmpty) {
                  //   Utils.showErrorSnack(context, 'All options are required');
                  //   return;
                  // }
                  // if (firstNameController.text.isEmpty ||
                  //     lastNameController.text.isEmpty ||
                  //     accountNumberController.text.isEmpty) {
                  //   Utils.showErrorSnack(context, 'All options are required');
                  //   return;
                  // }
                  context.pushNamed(Routes.transferAmountScreen);
                }),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
