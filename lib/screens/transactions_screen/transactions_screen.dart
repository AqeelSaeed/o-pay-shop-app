import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/screens/transactions_screen/filter_bottom_sheet.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

import '../dashboard/widgets/transaction_widget.dart';
import '../widgets/custom_appbar.dart';

class TransactionsScreen extends StatefulWidget {
  final List<TransactionHistoryModel> transactions;

  const TransactionsScreen({super.key, required this.transactions});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.transactions.tr(),
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller,
                    hintText: LocaleKeys.enterTextHere.tr(),
                    prefixIconPath: Assets.searchIcon,
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? darkTileColor
                            : Colors.white,
                    isScrollControlled: true,
                    builder: (context) => const FilterBottomSheet(),
                  ),
                  child: Container(
                    width: 52,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              itemCount: widget.transactions.length,
              itemBuilder: (context, index) =>
                  TransactionWidget(model: widget.transactions[index]),
            ),
          ),
        ],
      ),
    );
  }
}
