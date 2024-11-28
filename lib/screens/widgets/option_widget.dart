import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class OptionWidget extends StatefulWidget {
  final int value; // Value for the radio button
  final int? groupValue; // Group value for the radio button
  final ValueChanged<int?> onChanged; // Callback for value changes
  final Widget leadingAsset; // Path to the icon asset
  final String title; // Title text
  final String? subtitle; // Subtitle text

  const OptionWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leadingAsset,
    required this.title,
    this.subtitle,
  });

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            padding: EdgeInsets.all(widget.subtitle != null ? 0 : 13),
            decoration: const BoxDecoration(
              color: circleBorderColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: widget.leadingAsset),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Styles.regularTextTheme(context),
                ),
                widget.subtitle != null
                    ? Text(
                        widget.subtitle ?? '',
                        style: Styles.regularText.copyWith(
                          color: mediumGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Radio<int>(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: (int? value) {
              // Also call onChanged when radio button value is changed
              widget.onChanged(value);
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
