import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/notification_tabs/widgets/notfication_widget.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class SystemAlerts extends StatefulWidget {
  const SystemAlerts({super.key});

  @override
  State<SystemAlerts> createState() => _SystemAlertsState();
}

class _SystemAlertsState extends State<SystemAlerts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkScaffoldColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 26.0),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(5, (context) {
                return const NotificationWidget();
              }),
            ),
          ),
        ));
  }
}
