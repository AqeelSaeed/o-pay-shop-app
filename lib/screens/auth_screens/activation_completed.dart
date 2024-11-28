import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_stack_widget.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import '../../styles/styles.dart';
import '../../utils/assets_constants.dart';
import '../../utils/colors.dart';

class ActivationCompleted extends StatefulWidget {
  const ActivationCompleted({super.key});

  @override
  State<ActivationCompleted> createState() => _ActivationCompletedState();
}

class _ActivationCompletedState extends State<ActivationCompleted> {
  File firstFile = File('');
  File secondFile = File('');
  String? fileName1;
  String? fileName2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Text(
              LocaleKeys.completeActivation.tr(),
              style: Styles.appBarTextStyle.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : blackColor),
            ),
            Text(
              LocaleKeys.readAndAcceptLegal.tr(),
              style: Styles.regularText.copyWith(color: mediumGrey),
            ),
            const SizedBox(
              height: 30,
            ),
            filePickerContainer(
                text: fileName1 ?? LocaleKeys.uploadDocument.tr(),
                onTap: () async {
                  pickFirstFile();
                }),
            const SizedBox(
              height: 20,
            ),
            filePickerContainer(
                text: fileName2 ?? '${LocaleKeys.shopDocument},PDF',
                onTap: () async {
                  pickSecondFile();
                }),
            const Spacer(),
            CustomButton(
                text: LocaleKeys.submit.tr(),
                onPressed: () {
                  showCustomDialog();
                }),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  filePickerContainer({text, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Styles.regularMediumBlackStyle(context)
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 52,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: mediumGrey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Styles.regularText.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: mediumGrey),
              ),
              InkWell(
                  onTap: onTap,
                  child: Image.asset(
                    Assets.uploadIcon,
                    height: 20,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  // Method to pick the first file
  pickFirstFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      setState(() {
        fileName1 = path.basename(file.path); // Set the first file name
      });
      log('First file: ${file.path}');
      log('First fileName: $fileName1');
    } else {
      log("No file selected for the first file");
    }
  }

  // Method to pick the second file
  pickSecondFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      setState(() {
        fileName2 = path.basename(file.path); // Set the second file name
      });
      log('Second file: ${file.path}');
      log('Second fileName: $fileName2');
    } else {
      log("No file selected for the second file");
    }
  }

  void showCustomDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                const CustomStackWidget(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.successPng,
                          height: 134,
                        ),
                        Text(
                          LocaleKeys.accountActive.tr(),
                          style: Styles.appBarTextStyle
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          LocaleKeys.accountActiveMessage.tr(),
                          style:
                              Styles.regularText.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: LocaleKeys.finish.tr(),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Utils.goTo(context, Routes.loginScreen);
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              // const LoginScreen()), (Route<dynamic> route) => false);
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
