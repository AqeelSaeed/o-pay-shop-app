import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_slider_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/screens/widgets/dropdown_with_number_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class WithdrawSlider extends StatefulWidget {
  final double amount;
  final TransactionType transactionType;

  const WithdrawSlider({
    super.key,
    required this.amount,
    required this.transactionType,
  });

  @override
  State<WithdrawSlider> createState() => _WithdrawSliderState();
}

class _WithdrawSliderState extends State<WithdrawSlider> {
  String? selectedBank;
  String? selectedServiceProvider;

  final List<Map<String, String>> banks = [
    {
      'name': 'ABN AMRO BANK NV',
      'account': '12345-XXXX XXXX',
      'logo': Assets.abnBank,
    },
    {
      'name': 'Citi Bank',
      'account': '67890-YYYY YYYY',
      'logo': Assets.citiBank,
    },
    {
      'name': 'Bank of America',
      'account': '24680-ZZZZ ZZZZ',
      'logo': Assets.absaBank,
    },
  ];

  final List<Map<String, String>> serviceProviders = [
    {
      'name': 'Electricity Provider A',
      'logo': 'Assets.electricityProviderA',
    },
    {
      'name': 'Electricity Provider B',
      'logo': 'Assets.electricityProviderB',
    },
    {
      'name': 'Gas Provider A',
      'logo': 'Assets.gasProviderA',
    },
    {
      'name': 'Gas Provider B',
      'logo': 'Assets.gasProviderB',
    },
    {
      'name': 'Water Provider A',
      'logo': 'Assets.waterProviderA',
    },
    {
      'name': 'Water Provider B',
      'logo': 'Assets.waterProviderB',
    },
    {
      'name': 'Internet Provider A',
      'logo': 'Assets.internetProviderA',
    },
    {
      'name': 'Internet Provider B',
      'logo': 'Assets.internetProviderB',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomStackWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: kToolbarHeight + 10,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 6,
                ),
                width: double.infinity,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Utils.myBackButton(context),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _getTitle(),
                      style:
                          Styles.appBarTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ]),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? darkTileColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 5.0,
                        width: 70,
                        margin: const EdgeInsets.only(bottom: 20, top: 10),
                        decoration: BoxDecoration(
                          color: mediumGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                widget.transactionType ==
                                        TransactionType.payBill
                                    ? LocaleKeys.searchProvider.tr()
                                    : LocaleKeys.bankKey.tr(),
                                style: Styles.regularText.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : mediumGrey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              widget.transactionType == TransactionType.payBill
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton<String>(
                                        value: selectedServiceProvider,
                                        hint: Text(LocaleKeys
                                            .selectServiceProvider
                                            .tr()),
                                        items: serviceProviders.map((provider) {
                                          return DropdownMenuItem<String>(
                                            value: provider['name'],
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  provider['logo']!,
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(provider['name']!),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedServiceProvider = value;
                                          });
                                          log('Selected service provider: $value');
                                        },
                                      ),
                                    )
                                  : BankWithNumberDropDownComponent(
                                      banks: banks,
                                      defaultLogo: banks[0]['logo'],
                                      selectedBank:
                                          selectedBank ?? banks[0]['name'],
                                      onChanged: (String? selected) {
                                        setState(() {
                                          selectedBank = selected;
                                        });
                                        log('Selected bank: $selected');
                                      },
                                    ),
                              const SizedBox(height: 10),
                              Text(
                                LocaleKeys.amountKey.tr(),
                                style: Styles.regularText.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : mediumGrey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    '\$${widget.amount}',
                                    style: Styles.appBarTextStyle.copyWith(
                                      color: primaryColor,
                                      fontSize: 32,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomSlideButton(
                      amout: widget.amount,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (widget.transactionType) {
      case TransactionType.withdraw:
        return LocaleKeys.withdraw.tr();
      case TransactionType.transfer:
        return LocaleKeys.transfer_funds.tr();
      case TransactionType.payBill:
        return LocaleKeys.payBill.tr();
      default:
        return LocaleKeys.transactions.tr();
    }
  }
}
