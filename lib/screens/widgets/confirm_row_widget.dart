import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class ConfirmRowWidget extends StatelessWidget {
  final String labelKey, value;
  final bool isTotalPaymentKey;

  const ConfirmRowWidget(
      {super.key,
      required this.labelKey,
      required this.value,
      this.isTotalPaymentKey = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  Utils.getTranslatedLabel(context, labelKey),
                  style: Styles.regularMediumBlackStyle(context).copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // If dark theme, set text color to white
                        : (isTotalPaymentKey
                            ? Colors
                                .black // If light theme and label is for "Total Payment", set black color
                            : mediumGrey), // If light theme and not "Total Payment", set medium grey color
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Styles.regularMediumBlackStyle(context).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        isTotalPaymentKey
            ? const SizedBox.shrink()
            : const Divider(
                thickness: 0.3,
                height: 0.3,
                color: mediumGrey,
              ),
      ],
    );
  }
}
