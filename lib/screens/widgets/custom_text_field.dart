import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Color borderColor;
  final Color fillColor;
  final String? labelText;
  final Color prefixColor;
  final bool obscureText;
  final FocusNode? focusNode;
  final int inputLimit;
  final TextInputType? inputType;
  final Function()? onTap;
  final ValueChanged<String>? onAmountChanged;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIconPath,
      this.inputType,
      this.suffixIconPath,
      this.inputLimit = 11,
      this.obscureText = false,
      this.borderColor = const Color(0xFFD9D9D9),
      this.fillColor = Colors.white,
      this.prefixColor = Colors.black,
      this.labelText,
      this.focusNode,
      this.onTap,
      this.onAmountChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: Styles.regularTextTheme(context)
                .copyWith(fontWeight: FontWeight.w500),
          ),
        if (widget.labelText != null)
          const SizedBox(
            height: 10,
          ),
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          obscureText: widget.obscureText,
          cursorColor: blackColor,
          onTap: widget.onTap,
          readOnly: widget.onTap != null,
          style: Styles.regularText.copyWith(color: blackColor),
          maxLength: widget.inputLimit,
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: widget.hintText,
            hintStyle: Styles.regularText.copyWith(color: mediumGrey),
            prefixIcon: widget.prefixIconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Image.asset(
                      widget.prefixIconPath ?? '',
                      height: 10,
                      width: 10,
                      color: widget.prefixColor,
                    ),
                  )
                : null,
            suffixIcon: widget.suffixIconPath != null
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Image.asset(
                      widget.suffixIconPath ?? '',
                      height: 10,
                      width: 10,
                      color: widget.prefixColor,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            filled: true,
            fillColor: widget.fillColor,
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          onChanged: widget.onAmountChanged,
        ),
      ],
    );
  }
}
