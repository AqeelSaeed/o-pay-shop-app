import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/analytics_tabs/deposit_tab.dart';

class WithdrawTab extends StatefulWidget {
  const WithdrawTab({super.key});

  @override
  State<WithdrawTab> createState() => _WithdrawTabState();
}

class _WithdrawTabState extends State<WithdrawTab> {
  @override
  Widget build(BuildContext context) {
    return const DepositTab();
  }
}
