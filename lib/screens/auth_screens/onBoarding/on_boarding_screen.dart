import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/keys.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';

import '../../../utils/assets_constants.dart';
import 'onBoardItems/on_boarding_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool isShown = false;
  List<OnBoardingItem> onboardingItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        isOnboardShown();
      }
    });

    onboardingItems = [
      OnBoardingItem(
        imagePath: Assets.onBoardOne,
        headingOne: '${LocaleKeys.welcome_message.tr()} ',
        headingTwo: 'Zamapay',
        description: LocaleKeys.tagline.tr(),
      ),
      OnBoardingItem(
        imagePath: Assets.onBoardTwo,
        headingOne: '${LocaleKeys.deposit.tr()} ',
        headingTwo: LocaleKeys.funds_title.tr(),
        description: LocaleKeys.cash_deposit.tr(),
      ),
      OnBoardingItem(
        imagePath: Assets.onBoardThree,
        headingOne: '${LocaleKeys.withdraw.tr()} ',
        headingTwo: LocaleKeys.funds_title.tr(),
        description: LocaleKeys.cash_withdrawal.tr(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height <= 700;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: isSmallScreen ? kToolbarHeight - 25 : kToolbarHeight + 20,
          ),
          Image.asset(
            Assets.zamaLogo,
            height: isSmallScreen ? 80 : 100,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                    log('_currentPage: $_currentPage');
                  });
                },
                itemBuilder: (context, index) {
                  final item = onboardingItems[index];
                  return OnBoardingItem(
                    imagePath: item.imagePath,
                    headingOne: item.headingOne,
                    headingTwo: item.headingTwo,
                    description: item.description,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: isSmallScreen ? 40 : 55,
                    child: _buildPageIndicator()),
                SizedBox(height: isSmallScreen ? 25 : 35),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_currentPage == onboardingItems.length - 1) {
                        saveOnboardValue();
                        context.goNamed(Routes.loginScreen);
                        isOnboardShown();
                      } else {
                        _nextPage();
                      }
                    },
                    child: Image.asset(
                      Assets.onBoardNextBtn,
                      width: isSmallScreen ? 45 : 56,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < onboardingItems.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(onboardingItems.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: _currentPage == index ? 33.0 : 20,
            width: 9.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? primaryColor : lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }),
      ),
    );
  }

  void saveOnboardValue() {
    SharedPref.saveBool(key: Keys.isOnboardShown, value: true);
  }

  isOnboardShown() {
    isShown = true;
    log('isOnBoardShown: $isShown');
  }
}
