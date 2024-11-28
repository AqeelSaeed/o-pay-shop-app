import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/dashboard_widget.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/transaction_widget.dart';
import 'package:zamapay_shop_app/states/image_picker_state.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TransactionHistoryModel> modelList = [];

  @override
  void initState() {
    super.initState();

    modelList = [
      TransactionHistoryModel(
          Assets.userOne, 'Emma Watson', '(+221)7748577558', 24200, depositKey),
      TransactionHistoryModel(Assets.userTwo, 'Ellie Golden',
          '(+221)7748577558', 25000, withdrawKey),
      TransactionHistoryModel(Assets.userThree, 'Vin Deisel',
          '(+221)7748577558', 64000, transferKey),
      TransactionHistoryModel(
          Assets.userFour, 'Gallgadet', '(+221)7748577558', 56000, depositKey),
      TransactionHistoryModel(
          Assets.userOne, 'Jenifer', '(+221)7748577558', 32500, withdrawKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getContainerColor(context, primaryColor),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: Row(
                  children: [
                    Consumer<ImagePickerState>(
                        builder: (context, provider, child) {
                      return Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: provider.pickedImageFile != null
                                ? DecorationImage(
                                    image: FileImage(
                                        File(provider.pickedImageFile!.path)),
                                    fit: BoxFit.cover)
                                : const DecorationImage(
                                    image: AssetImage(Assets.dummyPic),
                                    fit: BoxFit.cover)),
                      );
                    }),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Utils.getTranslatedLabel(context, welcomeKey),
                          style: Styles.regularText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          'John Smith',
                          style: Styles.regularText.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DashboardWidget(
                context: context,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              decoration: BoxDecoration(
                  color: getTransactionListColor(context, Colors.white),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.transactions.tr(),
                        style: Styles.regularTextTheme(context).copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => context.push(Routes.transactionsScreen,
                            extra: modelList),
                        child: Text(
                          LocaleKeys.see_all.tr(),
                          style: Styles.regularTextTheme(context).copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: modelList.length > 4 ? modelList.length : 3,
                      itemBuilder: (context, index) {
                        var model = modelList[index];
                        return TransactionWidget(model: model);
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
