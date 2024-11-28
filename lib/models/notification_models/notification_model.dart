import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/utils/enums.dart';

class AlertModel {
  final String title;
  final String date;
  final String time;
  final String bodyText;
  final String iconPath;
  final Color circleColor;
  final AlertType type;

  AlertModel({
    required this.title,
    required this.date,
    required this.time,
    required this.bodyText,
    required this.iconPath,
    required this.circleColor,
    required this.type,
  });

  // Factory method to get the alert type and set the corresponding color and icon
  factory AlertModel.systemAlert({
    required String title,
    required String date,
    required String time,
    required String bodyText,
    required SystemAlertType systemAlertType,
  }) {
    switch (systemAlertType) {
      case SystemAlertType.systemUpdate:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/green_email.png', // Example icon path
          circleColor: Colors.green,
          type: AlertType.system,
        );
      case SystemAlertType.maintenance:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/purple_email.png',
          circleColor: Colors.purple,
          type: AlertType.system,
        );
      case SystemAlertType.featureRelease:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/red_email.png',
          circleColor: Colors.red,
          type: AlertType.system,
        );
    }
  }

  factory AlertModel.accountAlert({
    required String title,
    required String date,
    required String time,
    required String bodyText,
    required AccountAlertType accountAlertType,
  }) {
    switch (accountAlertType) {
      case AccountAlertType.depositRequest:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/blue_email.png',
          circleColor: Colors.blue,
          type: AlertType.account,
        );
      case AccountAlertType.withdrawalRequest:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/green_email.png',
          circleColor: Colors.green,
          type: AlertType.account,
        );
      case AccountAlertType.transferRequest:
        return AlertModel(
          title: title,
          date: date,
          time: time,
          bodyText: bodyText,
          iconPath: 'assets/purple_email.png',
          circleColor: Colors.purple,
          type: AlertType.account,
        );
    }
  }
}
