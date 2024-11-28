import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/styles.dart';
import '../../utils/colors.dart';

class OTPInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  const OTPInputWidget(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 58,
      child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.none,
          focusNode: focusNode,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.singleLineFormatter
          ],
          textAlign: TextAlign.center,
          cursorColor: primaryColor,
          maxLength: 1,
          style: Styles.appBarTextStyle
              .copyWith(fontWeight: FontWeight.w500, color: otpTextColor),
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            contentPadding: const EdgeInsets.all(10),
            fillColor: otpColor,
            filled: true,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: otpColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: otpColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: otpColor)),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          }),
    );
  }
}
