import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/screens/widgets/network_image_component.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';

import '../../utils/snippets.dart';
import '../widgets/custom_appbar.dart';
import 'enter_topup_number_screen.dart';

class SelectNetworkScreen extends StatefulWidget {
  final bool isPostpaid;

  const SelectNetworkScreen({super.key, required this.isPostpaid});

  @override
  State<SelectNetworkScreen> createState() => _SelectNetworkScreenState();
}

class _SelectNetworkScreenState extends State<SelectNetworkScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.selectNetwork.tr(),
        leadingAsset: Assets.backButton,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: searchController,
              hintText: LocaleKeys.searchServices.tr(),
              fillColor: Colors.white,
              suffixIconPath: Assets.searchIcon,
            ),
            const SizedBox(height: 30),
            Text(
              LocaleKeys.selectServices.tr(),
              style: Styles.regularMediumBlackStyle(context)
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                padding: const EdgeInsets.symmetric(vertical: 18),
                itemBuilder: (context, index) => ServicesTileWidget(
                  url:
                      'https://www.designevo.com/res/templates/thumb_small/white-ladder-and-red-signal.webp',
                  title: 'ARC TELECOM',
                  onTap: () {
                    push(context,
                        EnterTopupNumberScreen(isPostpaid: widget.isPostpaid));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesTileWidget extends StatelessWidget {
  final String url;
  final String title;
  final Function() onTap;

  const ServicesTileWidget(
      {super.key, required this.url, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            NetworkImageComponent(
              url: url,
              size: 45,
              borderColor: const Color(0xFFf0eeec),
              borderWidth: 5,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: Styles.regularText.copyWith(fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
