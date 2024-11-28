import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/models/detail_model.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/confirm_row_widget.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/states/otp_timer_provider.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class ConfirmationScreen extends StatefulWidget {
  final double confirmAmount;
  const ConfirmationScreen({super.key, required this.confirmAmount});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final List<DetailItem> details = [
    DetailItem(label: transactionNumberKey, value: '0944545345AZE45'),
    DetailItem(label: countryOfReceptionKey, value: 'Senegal'),
    DetailItem(label: paymentTypeKey, value: 'Cash deposit to customer'),
    DetailItem(label: dateTimeKey, value: 'June 3, 2024 10:34 PM'),
    DetailItem(label: subTotalKey, value: '\$47.15'),
    DetailItem(label: feeKey, value: '\$2.85'),
    DetailItem(label: totalPaymentKey, value: '\$50.00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: confirmKey,
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Image.asset(
                    Assets.confirmDetails,
                    height: 110,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '\$${widget.confirmAmount}',
                    style: Styles.appBarTextStyle.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Utils.getTranslatedLabel(context, depositSummaryKey),
                    style: Styles.regularText.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : mediumGrey),
                  ),
                  const SizedBox(height: 20),
                  const ConfirmRowWidget(
                      isTotalPaymentKey: false,
                      labelKey: transactionNumberKey,
                      value: '03654132AED'),
                  const ConfirmRowWidget(
                      labelKey: countryOfReceptionKey, value: 'Sydney'),
                  const ConfirmRowWidget(
                      labelKey: paymentTypeKey, value: 'Card'),
                  const ConfirmRowWidget(
                      labelKey: dateTimeKey, value: 'June 3, 2023, 10:00 AM'),
                  const ConfirmRowWidget(labelKey: subTotalKey, value: '\$200'),
                  const ConfirmRowWidget(labelKey: feeKey, value: '\$2.5'),
                  const ConfirmRowWidget(
                    labelKey: totalPaymentKey,
                    value: '\$3000',
                    isTotalPaymentKey: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
            child: CustomButton(
                text: LocaleKeys.confirm.tr(),
                onPressed: () {
                  context.read<OTPTimeProvider>().startTimer();
                  SharedPref.saveDouble(
                      key: 'confirmAmount', value: widget.confirmAmount);
                  log('confirmAmount: ${widget.confirmAmount}');
                  context.pushNamed(Routes.otpScreen, pathParameters: {
                    "isImageVerification": 'false',
                    "isPasswordChanged": 'false',
                    "value": 'deposit',
                  });
                }),
          )
        ],
      ),
    );
  }
}
