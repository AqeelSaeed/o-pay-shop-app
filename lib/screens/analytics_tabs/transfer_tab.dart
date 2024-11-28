import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/analytics_tabs/deposit_tab.dart';

class TransferTab extends StatefulWidget {
  const TransferTab({super.key});

  @override
  State<TransferTab> createState() => _TransferTabState();
}

class _TransferTabState extends State<TransferTab> {
  @override
  Widget build(BuildContext context) {
    return const DepositTab();
  }
}
