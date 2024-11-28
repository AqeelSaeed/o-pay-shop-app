import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class FundsOptionWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function() onTap;

  const FundsOptionWidget(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.subtitle,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 90,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    isSelected ? primaryLightColor : const Color(0xFFd9d9d9)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isSelected
                          ? primaryLightColor
                          : const Color(0xFFd9d9d9)),
                ),
                child: Center(
                  child: Image.asset(iconPath,
                      width: 20, color: isSelected ? primaryColor : mediumGrey),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.regularText
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    subtitle,
                    style: Styles.regularText.copyWith(color: mediumGrey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
