import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class CustomBankTileWidget extends StatefulWidget {
  final String? bankIconPath;
  final String? bankName;
  final Function() onTap;
  const CustomBankTileWidget(
      {super.key, this.bankIconPath, this.bankName, required this.onTap});

  @override
  State<CustomBankTileWidget> createState() => _CustomBankTileWidgetState();
}

class _CustomBankTileWidgetState extends State<CustomBankTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 58,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: addBankTileBgColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 46,
                  width: 48,
                  margin: const EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    color: widget.bankIconPath != null
                        ? Colors.transparent
                        : primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.bankIconPath == null
                      ? const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )
                      : Image.asset(
                          widget.bankIconPath ?? '',
                          height: 18,
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.bankName == null ? 'Add Bank' : widget.bankName ?? '',
                  style: Styles.regularText.copyWith(color: mediumBlack),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                Assets.arrowRightIcon,
                color: mediumBlack,
                height: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
