import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/analytics_tabs/deposit_tab.dart';
import 'package:zamapay_shop_app/screens/analytics_tabs/transfer_tab.dart';
import 'package:zamapay_shop_app/screens/analytics_tabs/withdraw_tab.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Tab> tabs = [
    Tab(
      height: 50,
      text: LocaleKeys.deposit.tr(),
    ),
    Tab(
      height: 50,
      text: LocaleKeys.withdraw.tr(),
    ),
    Tab(
      height: 50,
      text: LocaleKeys.transfer.tr(),
    )
  ];
  List<Widget> screens = [
    const DepositTab(),
    const WithdrawTab(),
    const TransferTab()
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Center(
            child: Text(
              LocaleKeys.analytics.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
          ),
          const SizedBox(
            height: 37,
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
              tabs: [
                Tab(
                  height: 50,
                  text: LocaleKeys.deposit.tr(),
                ),
                Tab(
                  height: 50,
                  text: LocaleKeys.withdraw.tr(),
                ),
                Tab(
                  height: 50,
                  text: LocaleKeys.transfer.tr(),
                )
              ],
              isScrollable: false,
            ),
          ),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: screens))
        ],
      ),
    );
  }
}
