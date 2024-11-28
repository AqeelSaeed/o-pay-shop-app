import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class Utils {
  static String getImagePath(String imageName) {
    return imageName;
  }

  static String getIconPath(String iconName) {
    return iconName;
  }

  static const String poppins = 'Poppins';

  static showSuccessSnack(BuildContext context, String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.greenAccent.shade200,
        content: Text(
          errorMessage,
          style: Styles.regularText.copyWith(color: Colors.white),
        )));
  }

  static showErrorSnack(BuildContext context, String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.redAccent.shade200,
        content: Text(
          errorMessage,
          style: Styles.regularText.copyWith(color: Colors.white),
        )));
  }

  static navigateBack(BuildContext context, route) {
    context.goNamed(route);
  }

  static goTo(BuildContext context, route) {
    context.goNamed(route);
  }

  static myBackButton(BuildContext context, {String? navigateTo}) {
    return GestureDetector(
      onTap: () {
        navigateTo != null ? context.pushNamed(navigateTo) : context.pop();
      },
      child: Image.asset(
        Assets.backButton,
        height: 65,
      ),
    );
  }

  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }

  static String getTranslatedLabel(BuildContext context, String labelKey) {
    return context.tr(labelKey);
  }

  showDepositSelectionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setStates) {
              return SizedBox(
                height: 214,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Center(
                        child: Text(
                          LocaleKeys.selectOption.tr(),
                          style: Styles.regularText.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.scannerScreen,
                                    pathParameters: {'deposit': 'yes'});
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: tabBarBgColor,
                                        ),
                                      ),
                                      Image.asset(
                                        Assets.qrCodeIcon,
                                        height: 70,
                                        width: 70,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.depositWithQR.tr(),
                                    style:
                                        Styles.regularMediumBlackStyle(context)
                                            .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            width: 0.3,
                            thickness: 0.3,
                            color: primaryColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.depositScreen,
                                    pathParameters: {'screenType': 'null'});
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: tabBarBgColor,
                                        ),
                                      ),
                                      Image.asset(
                                        Assets.userInfoIcon,
                                        height: 70,
                                        width: 70,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.depositWithID.tr(),
                                    style:
                                        Styles.regularMediumBlackStyle(context)
                                            .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            }),
          );
        });
  }
}
