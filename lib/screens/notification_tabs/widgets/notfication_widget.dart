import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import '../../../utils/lable_keys.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 56,
                width: 56,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: withdrawColor.withOpacity(0.2)),
                child: Image.asset(
                  Assets.greenEmail,
                  height: 15,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'System Update',
                      style: Styles.regularMediumBlackStyle(context)
                          .copyWith(height: 0.4, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          '04 June, 2024',
                          style: Styles.regularMediumBlackStyle(context)
                              .copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                            height: 35,
                            child: VerticalDivider(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : mediumBlack,
                              thickness: 1,
                              width: 10,
                              indent: 10,
                              endIndent: 10,
                            )),
                        Text(
                          '10:00 PM',
                          style: Styles.regularMediumBlackStyle(context)
                              .copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 3.5, bottom: 3.5, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                  ),
                  child: Text(
                    Utils.getTranslatedLabel(context, next),
                    style: Styles.regularText.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            Assets.notificationText,
            style: Styles.regularText.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : mediumGrey),
          )
        ],
      ),
    );
  }
}
