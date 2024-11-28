import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/selection_screen.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/snippets.dart';

// Utility Bill Screen with BillType parameter
class UtilityBillScreen extends StatefulWidget {
  final BillType billType;

  const UtilityBillScreen({
    super.key,
    required this.billType,
  });

  @override
  State<UtilityBillScreen> createState() => _UtilityBillScreenState();
}

class _UtilityBillScreenState extends State<UtilityBillScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the list of service providers based on the selected bill type
    List<ServiceProvider> utilityProviders =
        getProvidersForBillType(widget.billType);
    log('billType:${widget.billType}');
    return SelectionScreen(
      title: '${LocaleKeys.pay.tr()} ${getBillTypeName(widget.billType)}',
      description:
          '${LocaleKeys.selectServiceProviderFor.tr()} ${getBillTypeName(widget.billType)} ${LocaleKeys.payment.tr()}.',
      serviceProviderList: utilityProviders,
      serviceType: ServiceType.utility,
      onActionButtonTap: () {
        log('Searching for ${getBillTypeName(widget.billType)} providers');
        // Handle search functionality
      },
      onItemTap: (selectedItem) {
        // context.push(Routes.payBillScreen);
        context.pushNamed(Routes.billReferenceScreen,
            pathParameters: {'billType': '${widget.billType}'});
        log('Selected service provider: ${selectedItem.name}');
      },
    );
  }
}
