import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_numeric_keyboard.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class DepositAmountScreen extends StatefulWidget {
  final double depositCode;
  const DepositAmountScreen({super.key, required this.depositCode});

  @override
  State<DepositAmountScreen> createState() => _DepositAmountScreenState();
}

class _DepositAmountScreenState extends State<DepositAmountScreen> {
  TextEditingController amountController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Utils.myBackButton(context),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kate Winslet',
                            style: Styles.appBarTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '${LocaleKeys.account_number.tr()}: 0033001133513',
                            style: Styles.regularText
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '${LocaleKeys.transferCode.tr()}: ${widget.depositCode}',
                            style: Styles.regularText
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 5.0,
                            width: 70,
                            margin: const EdgeInsets.only(bottom: 30),
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
                              LocaleKeys.howMuchPay
                                  .tr(), // Dynamic instruction text
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
                              onChanged: (amount) {
                                setState(() {
                                  amountController.text = amount;
                                });
                              },
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
                              // Execute callback when done
                              if (amountController.text.isEmpty) {
                                Utils.showErrorSnack(
                                    context, 'Amount is missing');
                                return;
                              }

                              context.pushNamed(Routes.confirmationScreen,
                                  pathParameters: {
                                    'confirmAmount': amountController.text
                                  });
                            }),
                      )
                    ],
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

/*
@override
  Widget build(BuildContext context) {
    List<ServiceProvider> bankTileList = [
      ServiceProvider(
        'Citi Bank',
        Assets.citiBank,
      ),
      ServiceProvider(
        'ABN Bank',
        Assets.abnBank,
      ),
      ServiceProvider(
        'ABSA Bank Limited',
        Assets.absaBank,
      ),
      ServiceProvider(
        'Bank of America',
        Assets.citiBank,
      ),
    ];
    return SelectionScreen(
      title: Utils.getTranslatedLabel(context, withdrawKey),
      description: 'Select Bank for Withdrawal.',
      serviceProviderList: bankTileList,
      serviceType: ServiceType.bank,
      onActionButtonTap: () => context.push(Routes.addBankScreen),
      onItemTap: (selectedItem) {
        context.push(Routes.enterWithdrawAmountScreen);
        log('Selected bank: ${selectedItem.name}');
      },
    );
  }
 */

class BankTile {
  final String iconPath;
  final String bankName;

  BankTile(
    this.bankName,
    this.iconPath,
  );
}
