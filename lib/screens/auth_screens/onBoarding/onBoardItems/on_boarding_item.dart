import 'dart:core';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/utils.dart';

class OnBoardingItem extends StatefulWidget {
  final String imagePath;
  final String headingOne;
  final String headingTwo;
  final String description;
  const OnBoardingItem(
      {super.key,
      required this.imagePath,
      required this.headingOne,
      required this.headingTwo,
      required this.description});

  @override
  State<OnBoardingItem> createState() => _OnBoardingItemState();
}

class _OnBoardingItemState extends State<OnBoardingItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height <= 700;

    log('Device Height: ${size.height}');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: Image.asset(
            widget.imagePath,
            height: isSmallScreen ? size.height * 0.3 : size.height * 0.3,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        RichText(
          text: TextSpan(
              text: widget.headingOne,
              style: TextStyle(
                  color: blackColor,
                  fontFamily: Utils.poppins,
                  fontSize: isSmallScreen ? 20 : 25,
                  fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                    text: widget.headingTwo,
                    style: const TextStyle(
                      color: primaryColor,
                    ))
              ]),
        ),
        SizedBox(
          width: size.width * 0.7,
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: Styles.regularText.copyWith(
              color: mediumGrey,
            ),
          ),
        ),
      ],
    );
  }
}
