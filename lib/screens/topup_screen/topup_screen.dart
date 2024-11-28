import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

import '../../utils/snippets.dart';
import 'select_network_view.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  List<String> types = [LocaleKeys.postpaid.tr(), LocaleKeys.prepaid.tr()];
  late String selectedType;

  @override
  void initState() {
    selectedType = types[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        leadingAsset: Assets.backButton,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.selectService.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              types.length,
              (index) {
                return _Tile(
                  selected: selectedType == types[index],
                  icon: types[index] == LocaleKeys.postpaid.tr()
                      ? Assets.postpaidIcon
                      : Assets.prepaidIcon,
                  title: types[index],
                  onTap: () {
                    setState(() => selectedType = types[index]);
                  },
                );
              },
            ),
            const Spacer(),
            CustomButton(
              text: LocaleKeys.next.tr(),
              onPressed: () async {
                push(context,
                    SelectNetworkScreen(isPostpaid: selectedType == types[0]));
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final bool selected;
  final String icon;
  final String title;
  final Function() onTap;

  const _Tile(
      {required this.selected,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 14,
                  offset: const Offset(2, 3),
                ),
              ]),
          child: Row(
            children: [
              Image.asset(icon, width: 60),
              const SizedBox(width: 23),
              Text(title, style: Styles.regularText),
              const Spacer(),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: selected ? primaryColor : Colors.white,
                        shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
