import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/option_widget.dart';
import 'package:zamapay_shop_app/states/theme_state.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (themeProvider.themeMode == ThemeMode.light) {
      _selectedValue = 1;
    } else if (themeProvider.themeMode == ThemeMode.dark) {
      _selectedValue = 2;
    }
    return Scaffold(
      appBar: const CustomAppBar(
        title: themesKey,
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45),
            child: Column(
              children: [
                OptionWidget(
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });

                    themeProvider.setTheme(ThemeMode.light);
                  },
                  leadingAsset: Image.asset(Assets.lightModeIcon),
                  title: LocaleKeys.light_mode.tr(),
                ),
                const SizedBox(height: 25),
                OptionWidget(
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });

                    themeProvider.setTheme(ThemeMode.dark);
                  },
                  leadingAsset: Image.asset(Assets.darkModeIcon),
                  title: LocaleKeys.dark_mode.tr(),
                ),
              ],
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
