// Example widget that uses the SelectionScreen
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_bank_tile_widget.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

enum ServiceType {
  utility,
  bank,
}

class SelectionScreen extends StatefulWidget {
  final String title;
  final String description;
  final List<ServiceProvider> serviceProviderList;
  final ServiceType serviceType;
  final VoidCallback onActionButtonTap;
  final Function(ServiceProvider) onItemTap;

  const SelectionScreen({
    super.key,
    required this.title,
    required this.description,
    required this.serviceProviderList,
    required this.serviceType,
    required this.onActionButtonTap,
    required this.onItemTap,
  });

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log('screen size: ${size.height}');

    // Determine the action button text based on the service type
    String actionButtonText = widget.serviceType == ServiceType.bank
        ? LocaleKeys.addBank.tr()
        : LocaleKeys.searchServiceProvider.tr();

    return Scaffold(
      body: Stack(
        children: [
          const CustomStackWidget(),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Utils.myBackButton(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: Styles.appBarTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              widget.description,
                              style: Styles.regularText
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? darkTileColor
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 5.0,
                              width: 70,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                  color: mediumGrey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        widget.serviceType == ServiceType.bank
                            ? Text(
                                actionButtonText,
                                style: Styles.regularText
                                    .copyWith(color: mediumBlack),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.serviceType == ServiceType.bank
                            ? CustomBankTileWidget(
                                onTap: widget.onActionButtonTap,
                              )
                            : CustomTextField(
                                controller: TextEditingController(),
                                prefixColor: mediumBlack,
                                hintText: LocaleKeys.searchServiceProvider.tr(),
                                suffixIconPath: Assets.searchIcon),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.serviceType == ServiceType.bank
                              ? LocaleKeys.selectBank.tr()
                              : LocaleKeys.selectService.tr(),
                          style:
                              Styles.regularText.copyWith(color: mediumBlack),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.serviceProviderList.length,
                              itemBuilder: (context, index) {
                                var item = widget.serviceProviderList[index];
                                return CustomBankTileWidget(
                                  bankIconPath: item.iconPath,
                                  bankName: item.name,
                                  onTap: () => widget.onItemTap(item),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ServiceProvider {
  final String iconPath;
  final String name;

  ServiceProvider(
    this.name,
    this.iconPath,
  );
}
