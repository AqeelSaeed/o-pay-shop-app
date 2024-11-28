import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: helpCenter,
        leadingAsset: Assets.backButton,
      ),
      body: Center(
        child: Text(
          helpCenter.tr(),
          style: Styles.regularTextTheme(context),
        ),
      ),
    );
  }
}
