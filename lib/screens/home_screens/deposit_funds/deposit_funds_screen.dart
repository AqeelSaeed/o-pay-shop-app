import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/screens/widgets/dropdown_component.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class DepositFundsScreen extends StatefulWidget {
  final String? screenType;
  const DepositFundsScreen({super.key, this.screenType});

  @override
  State<DepositFundsScreen> createState() => _DepositFundsScreenState();
}

class _DepositFundsScreenState extends State<DepositFundsScreen> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedBank;

  List<String> dropItems = [
    'National Bank',
    'Al-Rajhi Bank',
    'Bank of America'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        leadingAsset: Assets.backButton,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                widget.screenType == 'bankTransactions'
                    ? LocaleKeys.bank_transactions.tr()
                    : LocaleKeys.depositFunds.tr(),
                style: Styles.appBarThemeStyle(context),
              ),
              Text(
                LocaleKeys.enableAgents.tr(),
                style: Styles.regularText.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : mediumGrey),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                  controller: customerNameController,
                  prefixIconPath: Assets.userIcon,
                  prefixColor: primaryColor,
                  labelText: LocaleKeys.customer_name.tr(),
                  hintText: LocaleKeys.name.tr(),
                  inputType: TextInputType.text),
              widget.screenType == 'bankTransactions'
                  ? const SizedBox(height: 20)
                  : const SizedBox.shrink(),
              widget.screenType == 'bankTransactions'
                  ? Text(
                      Utils.getTranslatedLabel(context, selectBankKey),
                      style: Styles.regularMediumBlackStyle(context)
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              widget.screenType == 'bankTransactions'
                  ? const SizedBox(height: 10)
                  : const SizedBox.shrink(),
              widget.screenType == 'bankTransactions'
                  ? DropdownComponent(
                      items: dropItems,
                      value: selectedBank,
                      hint: LocaleKeys.select_bank.tr(),
                      labelBuilder: (label) => label,
                      prefixIcon: Assets.bankIcon,
                      onChanged: (value) {
                        setState(() => selectedBank = value);
                      },
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: accountNumberController,
                  prefixIconPath: Assets.cardIcon,
                  prefixColor: primaryColor,
                  labelText: LocaleKeys.account_number.tr(),
                  hintText: '1234-6789-0120',
                  inputType: TextInputType.number),
              const SizedBox(height: 20),
              CustomTextField(
                controller: amountController,
                prefixIconPath: Assets.amonutIcon,
                prefixColor: primaryColor,
                labelText: LocaleKeys.amountKey.tr(),
                hintText: '\$0.00',
                inputType: TextInputType.number,
                onAmountChanged: (amount) {
                  setState(() {
                    amountController.text = amount;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: phoneController,
                prefixIconPath: Assets.phoneIcon,
                prefixColor: primaryColor,
                labelText: LocaleKeys.phoneNumber.tr(),
                hintText: LocaleKeys.optional.tr(),
                inputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: LocaleKeys.next.tr(),
                  onPressed: () {
                    // if (customerNameController.text.isEmpty &&
                    //     accountNumberController.text.isEmpty &&
                    //     amountController.text.isEmpty) {
                    //   Utils.showErrorSnack(
                    //       context, 'Something is missing please check');
                    //   return;
                    // }
                    context.pushNamed(Routes.confirmationScreen,
                        pathParameters: {'confirmAmount': '120.0'});
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
