import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class PayForTransferScreen extends StatefulWidget {
  const PayForTransferScreen({super.key});

  @override
  State<PayForTransferScreen> createState() => _PayForTransferScreenState();
}

class _PayForTransferScreenState extends State<PayForTransferScreen> {
  TextEditingController transferCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        LocaleKeys.payForTransfer.tr(),
                        style: Styles.appBarTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        LocaleKeys.enterReferenceNumber.tr(),
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
                              controller: transferCodeController,
                              cursorColor: Colors.transparent,
                              cursorWidth: 0,
                              keyboardType: TextInputType.number,
                              style: Styles.regularText.copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                              maxLength: 4,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counter: const SizedBox.shrink(),
                                  hintText: '0000',
                                  hintStyle: Styles.regularText.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: mediumGrey)),
                              onChanged: (transferCode) {
                                setState(() {
                                  transferCodeController.text = transferCode;
                                });
                              },
                            ),
                            const SizedBox(
                                height: 4), // Add some spacing if needed
                            Text(
                              LocaleKeys.enterTransferCode.tr(),
                              style: Styles.regularText.copyWith(
                                color: mediumGrey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff211E1D)
                        : Colors.white,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            // if (transferCodeController.text.isEmpty) {
                            //   Utils.showErrorSnack(
                            //       context, LocaleKeys.tra);
                            //   return;
                            // }
                            context.pushNamed(Routes.payForTransferAmountScreen,
                                pathParameters: {'transferCode': '231'});
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
                                  LocaleKeys.fetchDetails.tr(),
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
