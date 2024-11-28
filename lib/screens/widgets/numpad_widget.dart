import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class NumPadWidget extends StatefulWidget {
  final bool hideShadow;
  final int maxLength;
  final bool disableLengthCheck;
  final TextEditingController controller;
  final Function()? updateState;
  final Color? numbersColor;
  final Color? backgroundColor;
  final Color? actionButtonsColor;
  final Widget? replaceSubmitButton;
  final Function()? onSubmit;

  const NumPadWidget(
      {super.key,
      this.maxLength = 6,
      this.disableLengthCheck = false,
      required this.controller,
      this.hideShadow = false,
      this.numbersColor,
      this.backgroundColor = Colors.white,
      this.replaceSubmitButton,
      this.actionButtonsColor = primaryColor,
      this.updateState,
      this.onSubmit});

  @override
  State<NumPadWidget> createState() => _NumPadWidgetState();
}

class _NumPadWidgetState extends State<NumPadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: widget.hideShadow
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: const Offset(0, -4), // Shadow position
                )
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 1,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 2,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 3,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 4,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 5,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 6,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 7,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 8,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 9,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0, left: 15),
                child: IconButton(
                  onPressed: () {
                    if (widget.controller.text.isNotEmpty) {
                      setState(() {
                        widget.controller.text = widget.controller.text
                            .substring(0, widget.controller.text.length - 1);
                      });
                    }
                    if (widget.updateState != null) {
                      widget.updateState!();
                    }
                  },
                  icon: AnimatedCrossFade(
                      firstChild: Icon(
                        Icons.backspace_outlined,
                        color: widget.numbersColor,
                      ),
                      secondChild: const Icon(
                        Icons.backspace,
                        color: Colors.grey,
                      ),
                      crossFadeState: widget.controller.text.isEmpty
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300)),
                  iconSize: 40,
                ),
              ),
              _NumberButton(
                numbersColor: widget.numbersColor,
                number: 0,
                maxLength: widget.maxLength,
                controller: widget.controller,
                onPressed: widget.updateState ?? () => setState(() {}),
              ),
              widget.replaceSubmitButton ??
                  (widget.onSubmit == null
                      ? const SizedBox(width: 70)
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              if (widget.controller.text.length ==
                                      widget.maxLength ||
                                  widget.disableLengthCheck) {
                                widget.onSubmit!();
                              }
                            },
                            child: AnimatedContainer(
                              height: 40,
                              width: 60,
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (widget.controller.text.length ==
                                            widget.maxLength ||
                                        widget.disableLengthCheck)
                                    ? widget.actionButtonsColor
                                    : mediumGrey,
                              ),
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: Styles.regularText.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
            ],
          ),
        ],
      ),
    );
  }
}

// define _NumberButton widget
// its shape is round
class _NumberButton extends StatelessWidget {
  final int number;
  final Color? numbersColor;
  final int maxLength;
  final TextEditingController controller;
  final Function()? onPressed;

  const _NumberButton({
    this.numbersColor,
    required this.number,
    required this.maxLength,
    required this.onPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var size = 70;
    return SizedBox(
      width: size + 15,
      height: size - 15,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          // shadowColor:  ThemeProvider.transparent,
          // foregroundColor:  ThemeProvider.transparent,
        ),
        onPressed: () {
          if (controller.text.length < maxLength) {
            controller.text += number.toString();
            onPressed?.call();
          }
        },
        child: Center(
          child: Text(number.toString(),
              style: Styles.regularText
                  .copyWith(fontSize: 25, color: numbersColor)),
        ),
      ),
    );
  }
}
