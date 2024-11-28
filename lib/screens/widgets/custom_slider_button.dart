import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class CustomSlideButton extends StatefulWidget {
  final double amout;
  const CustomSlideButton({super.key, required this.amout});

  @override
  // ignore: library_private_types_in_public_api
  _CustomSlideButtonState createState() => _CustomSlideButtonState();
}

class _CustomSlideButtonState extends State<CustomSlideButton> {
  bool isSliding = false;
  double _slidePosition = 0.0;
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sliderWidth = screenWidth; // Slider container width
    double thumbSize = 60;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: Center(
        child: Stack(
          children: [
            // The background track
            Container(
              width: sliderWidth,
              height: thumbSize,
              decoration: BoxDecoration(
                color: sliderButtonBGColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                _isConfirmed
                    ? '${LocaleKeys.confirm.tr()}!'
                    : LocaleKeys.slideToConfirm.tr(),
                style: Styles.regularText
                    .copyWith(color: mediumBlack, fontSize: 16),
              ),
            ),
            // The sliding thumb
            Positioned(
              left: _slidePosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  updatePosition(
                      details.localPosition.dx, sliderWidth - thumbSize - 32);
                },
                onHorizontalDragEnd: (details) {
                  double maxPosition = sliderWidth - thumbSize - 32;
                  // Check if the thumb is fully slid
                  if (_slidePosition >= maxPosition) {
                    confirmSlide(maxPosition);
                    if (_isConfirmed) {
                      context.pushNamed(Routes.confirmationScreen,
                          pathParameters: {
                            'confirmAmount': widget.amout.toString()
                          }).whenComplete(() {});
                      log('Action Confirmed!');
                    }
                  } else {
                    reset();
                  }
                },
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    Assets.doubleRightIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePosition(double newPosition, double maxPosition) {
    setState(() {
      _slidePosition = newPosition.clamp(0.0, maxPosition);
    });
  }

  void confirmSlide(double maxPosition) {
    if (_slidePosition >= maxPosition) {
      setState(() {
        _isConfirmed = true;
      });
    }
  }

  void reset() {
    setState(() {
      _slidePosition = 0.0;
      _isConfirmed = false;
    });
  }
}
