import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/auth_screens/scanner_screen.dart.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/screens/widgets/dropdown_component.dart';
import 'package:zamapay_shop_app/states/image_picker_state.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/snippets.dart';

class AgentTab extends StatefulWidget {
  const AgentTab({super.key});

  @override
  State<AgentTab> createState() => _AgentTabState();
}

class _AgentTabState extends State<AgentTab> {
  String? selectedGender;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              LocaleKeys.signUp.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              LocaleKeys.simpleStepsAgent.tr(),
              style:
                  Styles.regularTextTheme(context).copyWith(color: mediumGrey),
            ),
            Consumer<ImagePickerState>(builder: (context, provider, child) {
              return Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    provider.pickImageFromGallery(ImageSource.gallery);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleKeys.uploadPhoto.tr(),
                        style: Styles.regularMediumBlackStyle(context),
                      )
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: firstNameController,
              prefixIconPath: Assets.personIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.firstName.tr(),
              hintText: LocaleKeys.firstName.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: lastNameController,
              prefixIconPath: Assets.personIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.lastName.tr(),
              hintText: LocaleKeys.lastName.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: phoneController,
              prefixIconPath: Assets.phoneIcon,
              inputType: TextInputType.phone,
              labelText: LocaleKeys.phoneNumber.tr(),
              hintText: LocaleKeys.phoneNumber.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: emailController,
              prefixIconPath: Assets.emailIcon,
              inputType: TextInputType.emailAddress,
              labelText: LocaleKeys.email.tr(),
              hintText: LocaleKeys.yourEmail.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: locationController,
              prefixIconPath: Assets.locationIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.location.tr(),
              hintText: LocaleKeys.yourAddress.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownComponent(
              title: LocaleKeys.gender.tr(),
              items: [LocaleKeys.male.tr(), LocaleKeys.female.tr()],
              value: selectedGender,
              hint: LocaleKeys.selectGender.tr(),
              labelBuilder: (label) => label,
              prefixIcon: Assets.genderIcon,
              onChanged: (value) {
                setState(() => selectedGender = value);
              },
            ),
            const SizedBox(
              height: 55,
            ),
            CustomButton(
                text: LocaleKeys.newKey.tr(),
                onPressed: () {
                  registerAsAgent();
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  registerAsAgent() {
    push(context, const ScannerScreen());
  }
}
