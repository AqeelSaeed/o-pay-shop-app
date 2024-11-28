import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/transaction_amount_screen.dart';
import 'package:zamapay_shop_app/utils/enums.dart';

class TransferAmountScreen extends StatefulWidget {
  const TransferAmountScreen({super.key});

  @override
  State<TransferAmountScreen> createState() => _TransferAmountScreenState();
}

class _TransferAmountScreenState extends State<TransferAmountScreen> {
  String amount = '';

  @override
  Widget build(BuildContext context) {
    return TransactionAmountScreen(
      title: LocaleKeys.makeTransfer.tr(),
      instructionText: LocaleKeys.howMuchTransfer.tr(),
      transactionType: TransactionType.transfer,
      balance: '63,00',
      onDone: () {
        log('amountController:$amount');
        context.pushNamed(Routes.confirmationScreen,
            pathParameters: {'confirmAmount': amount});
        // context.pushNamed(Routes.transferConfirmationScreen);
      },
      onAmountChanged: (String value) {
        setState(() {
          amount = value;
        });
      },
    );
  }
}
