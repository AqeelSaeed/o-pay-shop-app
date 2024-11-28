import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/transaction_amount_screen.dart';
import 'package:zamapay_shop_app/utils/enums.dart';

class BillAmountScreen extends StatefulWidget {
  final TransactionType billType;
  const BillAmountScreen({super.key, required this.billType});

  @override
  State<BillAmountScreen> createState() => _BillAmountScreenState();
}

class _BillAmountScreenState extends State<BillAmountScreen> {
  String amount = '';

  @override
  Widget build(BuildContext context) {
    log('transactionType: ${TransactionType.payBill}');
    return TransactionAmountScreen(
      title: LocaleKeys.payBill.tr(),
      instructionText: LocaleKeys.howMuchPay.tr(),
      transactionType: widget.billType,
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
          'transactionType': '${widget.billType}'
        });
      },
    );
  }
}
