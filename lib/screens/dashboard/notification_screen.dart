import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/notification_tabs/account_alerts.dart';
import 'package:zamapay_shop_app/screens/notification_tabs/system_alerts.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Tab> tabs = const [
    Tab(
      height: 50,
      text: 'System Alerts',
    ),
    Tab(
      height: 50,
      text: 'Account Alerts',
    ),
  ];

  List<Widget> screens = [const SystemAlerts(), const AccountAlerts()];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

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
              Utils.getTranslatedLabel(context, notificationKey),
              style: Styles.appBarThemeStyle(context),
            ),
          ),
          const SizedBox(
            height: 30,
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
                  text: Utils.getTranslatedLabel(context, systemAlertsKey),
                ),
                Tab(
                  height: 50,
                  text: Utils.getTranslatedLabel(context, accountAlertsKey),
                ),
              ],
              isScrollable: false,
            ),
          ),
          Expanded(
              child: TabBarView(controller: tabController, children: screens))
        ],
      ),
    );
  }
}
