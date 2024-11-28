import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/transaction_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TransactionHistoryModel> modelList = [
    TransactionHistoryModel(
        Assets.userOne, 'Emma Watson', '(+221)7748577558', 24200, depositKey),
    TransactionHistoryModel(
        Assets.userTwo, 'Ellie Golden', '(+221)7748577558', 25000, withdrawKey),
    TransactionHistoryModel(
        Assets.userThree, 'Vin Deisel', '(+221)7748577558', 64000, transferKey),
    TransactionHistoryModel(
        Assets.userFour, 'Gallgadet', '(+221)7748577558', 56000, depositKey),
    TransactionHistoryModel(
        Assets.userOne, 'Jenifer', '(+221)7748577558', 32500, withdrawKey),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? darkScaffoldColor
          : Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Center(
            child: Text(
              Utils.getTranslatedLabel(context, historyKey),
              style: Styles.appBarThemeStyle(context),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: modelList.length,
                  itemBuilder: (context, index) {
                    var model = modelList[index];
                    return TransactionWidget(
                      model: model,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
