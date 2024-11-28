import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class ReconciliationItemWidget extends StatelessWidget {
  final Function()? onTapReceipt;
  final Function()? onTapReconsiliation;
  final Function()? onTapReject;
  final Function()? onTapApprove;

  const ReconciliationItemWidget(
      {super.key,
      this.onTapReceipt,
      this.onTapReconsiliation,
      this.onTapReject,
      this.onTapApprove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTileColor
            : Colors.white,
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? darkTileColor
                : primaryLightColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(Assets.transferMoneyIcon),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.cashDeposit.tr(),
                style: Styles.regularMediumBlackStyle(context)
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Icon(Icons.attach_money, color: primaryColor, size: 18),
                  Text(
                    '55,000',
                    style: Styles.regularText.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : mediumGrey),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (onTapReceipt != null)
            _Icon(
              color: Theme.of(context).brightness == Brightness.dark
                  ? primaryColor
                  : const Color(0xFFE2D8D3),
              iconPath: Assets.receiptIcon,
              iconHeight: 16,
              iconColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : primaryColor,
              onTap: onTapReceipt,
            ),
          if (onTapReceipt != null) const SizedBox(width: 10),
          if (onTapReconsiliation != null)
            _Icon(
              color: primaryColor,
              iconPath: Assets.transferRecoincile,
              iconHeight: 19,
              onTap: onTapReconsiliation,
            ),
          if (onTapReject != null)
            _Icon(
              color: const Color(0xFFD42121),
              iconPath: Assets.timesIcon,
              onTap: onTapReject,
            ),
          if (onTapApprove != null)
            _Icon(
              color: const Color(0xFF21D428),
              iconPath: Assets.checkIcon,
              onTap: onTapApprove,
            ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final Color color;
  final Color? iconColor;
  final String iconPath;
  final double iconHeight;
  final Function()? onTap;

  const _Icon(
      {required this.color,
      this.iconColor,
      this.iconHeight = 11,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Image.asset(iconPath,
                color: iconColor ?? Colors.white, height: iconHeight)),
      ),
    );
  }
}
