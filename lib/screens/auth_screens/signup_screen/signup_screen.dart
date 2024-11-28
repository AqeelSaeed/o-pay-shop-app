import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/auth_screens/signup_screen/agent_tab.dart';
import 'package:zamapay_shop_app/screens/auth_screens/signup_screen/shop_tab.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import '../../../router/router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  List<Tab> tabs = [
    Tab(
      height: 50,
      text: LocaleKeys.signUpAsAgent.tr(),
    ),
    Tab(
      height: 50,
      text: LocaleKeys.signUpAsShop.tr(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, value) {
        log('popResult: ${value.toString()} .. $result');
        Utils.navigateBack(context, Routes.loginScreen);
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight + 20,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? mediumBlack
                      : tabBarBgColor,
                  borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                controller: tabController,
                tabs: tabs,
                // indicatorSize: TabBarIndicatorSize.tab,
                // dividerHeight: 0,
                isScrollable: false,
                // unselectedLabelColor: primaryColor,
                // labelStyle: Styles.regularText
                //     .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: primaryColor),
                // labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [AgentTab(), ShopTab()]))
          ],
        ),
      ),
    );
  }
}
