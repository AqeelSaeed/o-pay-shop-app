import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class BillReferenceScreen extends StatefulWidget {
  final BillType billType;
  const BillReferenceScreen({super.key, required this.billType});

  @override
  State<BillReferenceScreen> createState() => _BillReferenceScreenState();
}

class _BillReferenceScreenState extends State<BillReferenceScreen> {
  TextEditingController referenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('billType323: ${widget.billType}');
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
                        LocaleKeys.utilityBill.tr(),
                        style: Styles.appBarTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        LocaleKeys.enterBillReferenceNumber.tr(),
                        style: Styles.regularText.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? darkReferenceBgColor
                      : const Color(0xffF5F5F5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: referenceController,
                              cursorColor: Colors.transparent,
                              cursorWidth: 0,
                              keyboardType: TextInputType.number,
                              style: Styles.regularText.copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '123456',
                                  hintStyle: Styles.regularText.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: mediumGrey)),
                            ),
                            const SizedBox(
                                height: 4), // Add some spacing if needed
                            Text(
                              LocaleKeys.enterEightDigitReferenceNumber.tr(),
                              style: Styles.regularText.copyWith(
                                color: mediumGrey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Image.asset(
                      //     Assets.scanIcon,
                      //     height: 45,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkTileColor
                        : Colors.white,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.billAmountScreen,
                                pathParameters: {
                                  'billType': '${widget.billType}'
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 42.0, horizontal: 16.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.fetchBill.tr(),
                                  style: Styles.regularText.copyWith(
                                      color: Colors.white, fontSize: 15),
                                ),
                                const Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
