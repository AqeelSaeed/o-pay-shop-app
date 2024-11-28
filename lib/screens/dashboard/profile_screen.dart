import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/card_widget.dart';
import 'package:zamapay_shop_app/states/image_picker_state.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CardModel> cardList = [];

  @override
  void initState() {
    super.initState();
    cardList = [
      CardModel(Assets.userIcon, () {
        log('My Account Tab');
        context.push(Routes.myAccountScreen);
      }, myAccount),
      CardModel(Assets.keyIcon, () {
        log('Change Password Tab');
        context.push(Routes.changePasswordScreen);
      }, changePasswordKey),
      CardModel(Assets.paletteIcon, () {
        log('Themes Tab');
        context.push(Routes.themesScreen);
      }, themes),
      CardModel(Assets.languagesIcon, () {
        log('Languages Tab');
        context.push(Routes.languageScreen);
      }, languages),
      CardModel(Assets.helpCenterIcon, () {
        log('Help Center Tab');
        context.push(Routes.helpCenterScreen);
      }, helpCenter),
      CardModel(Assets.contactSupportIcon, () {
        log('Contact Support Tab');
        context.push(Routes.contactSupportScreen);
      }, contactSupport),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ImagePickerState>().getImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTileColor
          : Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                Utils.getTranslatedLabel(context, profileKey),
                style: Styles.appBarThemeStyle(context),
              ),
            ),
          ),
          Expanded(
            child: ListView(children: [
              Column(
                children: [
                  const Divider(
                    color: mediumGrey,
                    thickness: 0.3,
                    height: 0.3,
                  ),
                  Material(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkTileColor
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          Consumer<ImagePickerState>(
                              builder: (context, provider, child) {
                            return Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: circleBorderColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: circleBorderColor),
                                  image: provider.pickedImageFile != null
                                      ? DecorationImage(
                                          image: FileImage(File(
                                              provider.pickedImageFile!.path)),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image: AssetImage(Assets.dummyPic))),
                            );
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Smith',
                                style:
                                    Styles.regularTextTheme(context).copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '(+221)7748577558',
                                style: Styles.regularTextTheme(context)
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: mediumGrey,
                    thickness: 0.3,
                    height: 0.3,
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkScaffoldColor
                        : Colors.white,
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkTileColor
                        : Colors.white,
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cardList.length,
                            itemBuilder: (context, index) {
                              var data = cardList[index];
                              return CardWidget(
                                iconPath: data.iconPath,
                                title: data.title,
                                onTap: data.onTap,
                              );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: InkWell(
              onTap: () {
                context.go(Routes.loginScreen);
              },
              child: Text(
                LocaleKeys.logout.tr(),
                style: Styles.regularTextTheme(context).copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color(0xffD42121)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardModel {
  String title;
  String iconPath;
  VoidCallback onTap;

  CardModel(this.iconPath, this.onTap, this.title);
}
