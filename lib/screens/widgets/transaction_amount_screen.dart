import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_numeric_keyboard.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class TransactionAmountScreen extends StatefulWidget {
  final String title;
  final String instructionText;
  final TransactionType transactionType;
  final String balance;
  final VoidCallback onDone;

  final ValueChanged<String> onAmountChanged;

  const TransactionAmountScreen(
      {super.key,
      required this.title,
      required this.instructionText,
      required this.transactionType,
      required this.balance,
      required this.onDone,
      required this.onAmountChanged});

  @override
  State<TransactionAmountScreen> createState() =>
      _TransactionAmountScreenState();
}

class _TransactionAmountScreenState extends State<TransactionAmountScreen> {
  TextEditingController amountController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    amountController.addListener(() {
      widget.onAmountChanged(amountController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomStackWidget(),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: kToolbarHeight + 16,
                  width: double.infinity,
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Utils.myBackButton(context)),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: Styles.appBarTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.total_balance.tr(),
                        style: Styles.regularText.copyWith(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.balance}',
                            style: Styles.regularText.copyWith(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 5.0,
                              width: 70,
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              decoration: BoxDecoration(
                                  color: mediumGrey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.setAmountKey.tr(),
                                style: Styles.regularText
                                    .copyWith(color: mediumBlack),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.instructionText,
                                style: Styles.regularText
                                    .copyWith(color: mediumGrey),
                              ),
                              TextFormField(
                                controller: amountController,
                                textAlign: TextAlign.center,
                                cursorHeight: 0,
                                autofocus: true,
                                keyboardType: TextInputType.none,
                                style: Styles.regularText.copyWith(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.white,
                                  focusColor: Colors.transparent,
                                ),
                                onChanged: widget.onAmountChanged,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.3,
                          height: 0.3,
                          color: mediumGrey,
                        ),
                        NumericKeypad(
                          controllers: [amountController],
                          focusNodes: [focusNode],
                          isSingleField: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 25),
                          child: CustomButton(
                              text: LocaleKeys.done.tr(),
                              onPressed: () {
                                if (amountController.text.isEmpty) {
                                  Utils.showErrorSnack(
                                      context, 'Amount is missing');
                                  return;
                                }
                                widget.onDone();
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
