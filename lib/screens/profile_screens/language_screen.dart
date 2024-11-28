import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/option_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // List of language options with corresponding locales
  final List<Map<String, dynamic>> options = [
    {
      'value': 1,
      'title': 'English',
      'subtitle': 'Hello',
      'locale': const Locale('en', 'US'),
      'leadingAsset': Text(
        'E',
        style: Styles.appBarTextStyle.copyWith(color: primaryColor),
      ),
    },
    {
      'value': 2,
      'title': 'South Africa',
      'subtitle': 'Xhosa',
      'locale': const Locale('af', 'ZA'),
      'leadingAsset': Text(
        'S',
        style: Styles.appBarTextStyle.copyWith(color: primaryColor),
      ),
    },
    {
      'value': 3,
      'title': 'Spanish',
      'subtitle': 'Hola',
      'locale': const Locale('es', 'ES'),
      'leadingAsset': Text(
        'S',
        style: Styles.appBarTextStyle.copyWith(color: primaryColor),
      ),
    },
    {
      'value': 4,
      'title': 'France',
      'subtitle': 'Bonjour',
      'locale': const Locale('fr', 'FR'),
      'leadingAsset': Text(
        'F',
        style: Styles.appBarTextStyle.copyWith(color: primaryColor),
      ),
    },
  ];

  // By default, English is selected
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    // Get the current locale information
    Locale currentLocale = context.locale;
    String currentLanguage = currentLocale.languageCode;
    log('Selected Locale: $currentLanguage');
    if (currentLanguage == 'en') {
      selectedValue = 1;
    } else if (currentLanguage == 'af') {
      selectedValue = 2;
    } else if (currentLanguage == 'es') {
      selectedValue = 3;
    } else if (currentLanguage == 'fr') {
      selectedValue = 4;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: LocaleKeys.language.tr(),
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45),
            child: Column(
              children: List.generate(options.length, (index) {
                final option = options[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: OptionWidget(
                    value: option['value'],
                    groupValue: selectedValue, // Currently selected value
                    onChanged: (int? value) {
                      context.setLocale(option['locale']);
                      if (value != null) {
                        setState(() {
                          selectedValue = value;
                          // Update the locale based on the selected language
                        });
                      }
                    },
                    leadingAsset: option['leadingAsset'],
                    title: option['title'],
                    subtitle: option['subtitle'],
                  ),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.flip(
              flipX: true,
              flipY: true,
              child: Image.asset(
                Assets.splashPattern,
                color: primaryColor,
                height: 200,
              ),
            ),
          )
        ],
      ),
    );
  }
}
