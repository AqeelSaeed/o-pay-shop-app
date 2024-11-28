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

class ShopTab extends StatefulWidget {
  const ShopTab({super.key});

  @override
  State<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  String? selectedGender;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    shopNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    businessTypeController.dispose();
    passwordController.dispose();
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
              LocaleKeys.registration.tr(),
              style: Styles.appBarThemeStyle(context),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              LocaleKeys.createAccount.tr(),
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
              controller: fullNameController,
              prefixIconPath: Assets.personIcon,
              labelText: LocaleKeys.fullName.tr(),
              inputType: TextInputType.text,
              hintText: LocaleKeys.name.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: shopNameController,
              prefixIconPath: Assets.shopIcon,
              labelText: LocaleKeys.shopName.tr(),
              inputType: TextInputType.text,
              hintText: LocaleKeys.shopName.tr(),
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
              controller: businessTypeController,
              prefixIconPath: Assets.businessTypeIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.businessType.tr(),
              hintText: LocaleKeys.typeOfBusiness.tr(),
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
              controller: locationController,
              prefixIconPath: Assets.locationIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.location.tr(),
              hintText: LocaleKeys.yourAddress.tr(),
              prefixColor: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: passwordController,
              prefixIconPath: Assets.lockIcon,
              inputType: TextInputType.text,
              labelText: LocaleKeys.password.tr(),
              hintText: LocaleKeys.password.tr(),
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
                text: LocaleKeys.next.tr(),
                onPressed: () {
                  registerAsShop();
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  registerAsShop() {
    // if (fullNameController.text.isEmpty &&
    //     shopNameController.text.isEmpty &&
    //     emailController.text.isEmpty &&
    //     businessTypeController.text.isEmpty &&
    //     phoneController.text.isEmpty &&
    //     locationController.text.isEmpty &&
    //     passwordController.text.isEmpty &&
    //     (selectedGender == null)) {
    //   Utils.showErrorSnack(context, 'Please check form');
    //   return;
    // }
    // if (fullNameController.text.isEmpty ||
    //     shopNameController.text.isEmpty ||
    //     emailController.text.isEmpty ||
    //     businessTypeController.text.isEmpty ||
    //     phoneController.text.isEmpty ||
    //     locationController.text.isEmpty ||
    //     passwordController.text.isEmpty ||
    //     (selectedGender == null)) {
    //   Utils.showErrorSnack(context, 'Please check form');
    //   return;
    // }
    push(context, const ScannerScreen());
  }
}
