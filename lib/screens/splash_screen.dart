import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/keys.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (SharedPref.getBool(key: Keys.isOnboardShown) == true) {
          context.goNamed(Routes.loginScreen);
        } else {
          context.goNamed(Routes.onBoarding);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? darkScaffoldColor
          : primaryColor,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(Assets.splashPattern,
                  color: splashPaternColor, width: 150),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: _scale),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Image.asset(
                      Assets.splashLogo,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.flip(
                flipX: true,
                flipY: true,
                child: Image.asset(Assets.splashPattern,
                    color: splashPaternColor, width: 150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
