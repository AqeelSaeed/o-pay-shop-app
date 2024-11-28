import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class TransactionWidget extends StatefulWidget {
  final TransactionHistoryModel model;
  const TransactionWidget({super.key, required this.model});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: circleBorderColor, style: BorderStyle.solid),
                image:
                    DecorationImage(image: AssetImage(widget.model.imagePath))),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.name,
                    style: Styles.getTransactionItemStyle(context),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.model.phoneNumber,
                    style: Styles.getTransactionItemStyle(context).copyWith(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : mediumGrey,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${widget.model.amount}',
                style: Styles.transactionItemStyle.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryColor,
                ),
              ),
              Text(
                Utils.getTranslatedLabel(context, widget.model.transationType),
                style: Styles.transactionItemStyle.copyWith(
                    fontSize: 14,
                    color: widget.model.transationType == 'Deposit'
                        ? Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : depositColor
                        : widget.model.transationType == 'Withdraw'
                            ? Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : withdrawColor
                            : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : transferColor,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
