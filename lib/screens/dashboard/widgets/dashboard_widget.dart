import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/qr_popup.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/transaction_item_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class DashboardWidget extends StatefulWidget {
  final BuildContext context;
  const DashboardWidget({super.key, required this.context});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<TransactionItemWidget> transactionItemWidgets = [];

  bool isBalanceHidden = true;
  double bannerHeight = 430;
  double maxHeight = 430;
  double minHeight = 270;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    log('height: $screenHeight');
    initGridItems();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTileColor
            : primaryLightColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            screenHeight.round().toString(),
                            style: Styles.regularText
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            LocaleKeys.total_balance.tr(),
                            style: Styles.regularText
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => setState(
                                () => isBalanceHidden = !isBalanceHidden),
                            child: Icon(
                              isBalanceHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                isBalanceHidden ? '●●●●●●●●' : '348722230.22',
                                style: Styles.regularText.copyWith(
                                    color: Colors.white,
                                    fontSize: isBalanceHidden ? 15 : 28,
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'CFA',
                              style: Styles.regularText.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 75,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: '',
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const QrPopup(),
                              ),
                          child: const Icon(
                            Icons.qr_code_2_outlined,
                            color: primaryColor,
                            size: 55,
                          )),
                      Text(
                        LocaleKeys.my_qr.tr(),
                        style: Styles.regularText
                            .copyWith(color: primaryColor, fontSize: 13),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 130,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactionItemWidgets.length,
              itemBuilder: (context, index) {
                final item = transactionItemWidgets[index];
                return TransactionItemWidget(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  initGridItems() {
    // List of transaction items data
    transactionItemWidgets = [
      TransactionItemWidget(
        icon: Assets.depositFunds,
        title: LocaleKeys.depositFunds.tr(),
        onTap: () => Utils().showDepositSelectionDialog(context),
      ),
      TransactionItemWidget(
        icon: Assets.withDrawFunds,
        title: Utils.getTranslatedLabel(context, LocaleKeys.payTransfer.tr()),
        onTap: () => context.push(Routes.payForTransferScreen),
      ),
      TransactionItemWidget(
        icon: Assets.transferFunds,
        title: Utils.getTranslatedLabel(context, LocaleKeys.makeTransfer.tr()),
        onTap: () => context.push(Routes.transferDetailsScreen),
      ),
      TransactionItemWidget(
        icon: Assets.transferRecoincile,
        title: LocaleKeys.reconciliations.tr(),
        onTap: () => context.push(Routes.reconciliationsScreen),
      ),
      TransactionItemWidget(
        icon: Assets.utilityBillsIcon,
        title: LocaleKeys.utility_bills.tr(),
        onTap: () => showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? darkTileColor
              : Colors.white,
          isScrollControlled: true,
          builder: (context) => _UtilityBillsBottomSheet(),
        ),
      ),
      TransactionItemWidget(
        icon: Assets.withDrawFunds,
        title: LocaleKeys.bank_transactions.tr(),
        onTap: () => context.pushNamed(
          Routes.depositScreen,
          pathParameters: {'screenType': 'bankTransactions'},
        ),
      ),
      TransactionItemWidget(
        icon: Assets.transferFunds,
        title: LocaleKeys.top_up.tr(),
        onTap: () => context.push(Routes.topupScreen),
      ),
      TransactionItemWidget(
        icon: Assets.transferRecoincile,
        title: LocaleKeys.transfer_reconciliation.tr(),
        onTap: () => context.push(Routes.transferRecoinciliationsScreen),
      ),
    ];

    // Calculate the number of columns based on the device's width
    final double screenWidth = MediaQuery.of(context).size.width;
    final int columns =
        screenWidth > 600 ? 4 : 2; // 4 columns for tablets, 2 for phones
  }
}

class _UtilityBillsBottomSheet extends StatefulWidget {
  @override
  State<_UtilityBillsBottomSheet> createState() =>
      _UtilityBillsBottomSheetState();
}

class _UtilityBillsBottomSheetState extends State<_UtilityBillsBottomSheet> {
  String? _selectedBillType;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _BillItem(
          icon: Assets.utilityBillsIcon,
          title: LocaleKeys.electricBill.tr(),
          isSelected: _selectedBillType == BillType.electricity.toString(),
          onTap: () {
            setState(() {
              _selectedBillType = BillType.electricity.toString();
            });
            context.pushNamed(Routes.utilityBillScreen,
                pathParameters: {'billType': BillType.electricity.toString()});
          },
        ),
        _BillItem(
          icon: Assets.waterBillIcon,
          title: LocaleKeys.waterBill.tr(),
          isSelected: _selectedBillType == BillType.water.toString(),
          onTap: () {
            setState(() {
              _selectedBillType = BillType.water.toString();
            });
            context.pushNamed(Routes.utilityBillScreen,
                pathParameters: {'billType': BillType.water.toString()});
          },
        ),
        _BillItem(
          icon: Assets.gasBillIcon,
          title: LocaleKeys.gasBill.tr(),
          isSelected: _selectedBillType == BillType.gas.toString(),
          onTap: () {
            setState(() {
              _selectedBillType = BillType.gas.toString();
            });
            context.pushNamed(Routes.utilityBillScreen,
                pathParameters: {'billType': BillType.gas.toString()});
          },
        ),
        _BillItem(
          icon: Assets.internetBillIcon,
          title: LocaleKeys.internetBill.tr(),
          isSelected: _selectedBillType == BillType.internet.toString(),
          onTap: () {
            setState(() {
              _selectedBillType = BillType.internet.toString();
            });
            context.pushNamed(Routes.utilityBillScreen,
                pathParameters: {'billType': BillType.internet.toString()});
          },
        ),
      ],
    );
  }
}

class _BillItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final Function() onTap;

  const _BillItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false, // New property to track selection
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? primaryColor
                    : tabBarBgColor, // Change background color
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : primaryColor, // Change icon color
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.regularMediumBlackStyle(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
