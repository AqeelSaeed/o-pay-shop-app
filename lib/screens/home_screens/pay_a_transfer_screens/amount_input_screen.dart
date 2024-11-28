import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/transaction_amount_screen.dart';
import 'package:zamapay_shop_app/utils/enums.dart';

class AmountInputScreen extends StatefulWidget {
  const AmountInputScreen({super.key});

  @override
  State<AmountInputScreen> createState() => _AmountInputScreenState();
}

class _AmountInputScreenState extends State<AmountInputScreen> {
  String amount = '';

  @override
  Widget build(BuildContext context) {
    return TransactionAmountScreen(
      title: LocaleKeys.withdrawFunds.tr(),
      instructionText: LocaleKeys.howMuchTransfer.tr(),
      transactionType: TransactionType.withdraw,
      balance: '30,00',
      onAmountChanged: (value) {
        setState(() {
          amount = value;
        });
      },
      onDone: () {
        log('amountController:$amount');
        context.pushNamed(Routes.withDrawSliderScreen, pathParameters: {
          'amount': amount,
          'transactionType': '${TransactionType.withdraw}'
        });
      },
    );
  }
}
