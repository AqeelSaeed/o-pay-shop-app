import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class CustomStackWidget extends StatefulWidget {
  const CustomStackWidget({super.key});

  @override
  State<CustomStackWidget> createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color(0xff211E1D),
      child: Stack(
        children: [
          Positioned(
            right: -90,
            top: -90,
            child: Container(
              height: 230,
              width: 230,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            right: -105,
            top: -105,
            child: Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
