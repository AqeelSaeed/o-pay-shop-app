import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class CardWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  const CardWidget(
      {super.key,
      required this.iconPath,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: tabBarBgColor, shape: BoxShape.circle),
              child: Image.asset(iconPath),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              Utils.getTranslatedLabel(context, title),
              style: Styles.regularTextTheme(context),
            ),
            const Spacer(),
            Image.asset(
              Assets.arrowRightIcon,
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
