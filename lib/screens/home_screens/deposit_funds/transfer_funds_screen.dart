import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

import '../widgets/funds_option_widget.dart';

class TransferFundsScreen extends StatefulWidget {
  const TransferFundsScreen({super.key});

  @override
  State<TransferFundsScreen> createState() => _TransferFundsScreenState();
}

class _TransferFundsScreenState extends State<TransferFundsScreen> {
  late FundsOptionModel selectedOption;

  List<FundsOptionModel> fundsOptions = [
    FundsOptionModel(
      id: 1,
      iconPath: Assets.walletIcon,
      title: 'Wallet',
      subtitle: 'Send to Wallet',
      navigateTo: '',
    ),
    FundsOptionModel(
      id: 2,
      iconPath: Assets.phoneIcon,
      title: 'Phone Number',
      subtitle: 'Send to Phone Number',
      navigateTo: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedOption = fundsOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: '',
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 20),
          // Utils.myBackButton(context),
          // const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transfer Funds',
                  style: Styles.appBarTextStyle,
                ),
                const SizedBox(height: 5),
                Text(
                  'Select Bank or Phone Number',
                  style: Styles.regularText.copyWith(color: mediumGrey),
                ),
                const SizedBox(height: 30),
                ...fundsOptions.map(
                  (option) => FundsOptionWidget(
                    iconPath: option.iconPath,
                    title: option.title,
                    subtitle: option.subtitle,
                    isSelected: option == selectedOption,
                    onTap: () {
                      setState(() => selectedOption = option);
                      log('selectedOption:${selectedOption.title}');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
            text: 'Next',
            onPressed: () {
              context.pushNamed(Routes.transferDetailsScreen,
                  pathParameters: {'typeOfFunds': selectedOption.title});
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FundsOptionModel {
  final int id;
  final String iconPath;
  final String title;
  final String subtitle;
  final String navigateTo;

  FundsOptionModel({
    required this.id,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.navigateTo,
  });
}
