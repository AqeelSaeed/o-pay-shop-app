import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/transactions_screen/reconciliation_bottom_sheet.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import 'widgets/reconciliation_item_widget.dart';

class TransferRecoincilationScreen extends StatefulWidget {
  const TransferRecoincilationScreen({super.key});

  @override
  State<TransferRecoincilationScreen> createState() =>
      _TransferRecoincilationScreenState();
}

class _TransferRecoincilationScreenState
    extends State<TransferRecoincilationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Utils.myBackButton(context),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.transactionReconciliation.tr(),
                  style: Styles.appBarThemeStyle(context),
                ),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.allowAgentsToResolveDiscrepancies.tr(),
                  style: Styles.regularText.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : mediumGrey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return ReconciliationItemWidget(
                  onTapReconsiliation: () => showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? darkTileColor
                              : Colors.white,
                      isScrollControlled: true,
                      builder: (context) => const ReconciliationBottomSheet()),
                  onTapReject: () {
                    //
                  },
                  onTapApprove: () {
                    //
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
