import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/states/image_picker_state.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? pickedImageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ImagePickerState>().getImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: myAccount,
        leadingAsset: Assets.backButton,
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:
              Consumer<ImagePickerState>(builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
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
                    GestureDetector(
                        onTap: () async {
                          provider.pickImageFromGallery(ImageSource.gallery);
                        },
                        child: Text(
                          LocaleKeys.changePicture.tr(),
                          style: Styles.regularTextTheme(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Divider(
                  thickness: 0.3,
                  height: 0.3,
                  color: mediumGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 25),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: fullNameController,
                        prefixIconPath: Assets.userIcon,
                        inputType: TextInputType.text,
                        labelText: LocaleKeys.fullName.tr(),
                        hintText: LocaleKeys.name.tr(),
                        prefixColor: primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: emailController,
                        prefixIconPath: Assets.emailIcon,
                        labelText: LocaleKeys.email.tr(),
                        hintText: LocaleKeys.email.tr(),
                        inputType: TextInputType.emailAddress,
                        prefixColor: primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        prefixIconPath: Assets.phoneIcon,
                        labelText: LocaleKeys.phoneNumber.tr(),
                        hintText: LocaleKeys.phoneNumber.tr(),
                        inputType: TextInputType.phone,
                        prefixColor: primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          text: LocaleKeys.saveChanges.tr(),
                          onPressed: () {
                            // if (fullNameController.text.isEmpty &&
                            //     emailController.text.isEmpty &&
                            //     phoneController.text.isEmpty) {
                            //   Utils.showErrorSnack(
                            //       context, LocaleKeys.enterRequiredInfo.tr());
                            //   return;
                            // }
                            // if (fullNameController.text.isEmpty ||
                            //     emailController.text.isEmpty ||
                            //     phoneController.text.isEmpty) {
                            //   Utils.showErrorSnack(
                            //       context, 'All fields are required');
                            //   return;
                            // }
                            SharedPref.saveString(
                                    key: 'user-image',
                                    value: provider.pickedImageFile!.path)
                                .whenComplete(() {
                              if (mounted) {
                                Utils.showSuccessSnack(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    'User Info Updated Successfully');
                                log('saveImage:${SharedPref.getString(key: 'user-image')}');
                              }
                            });
                          })
                    ],
                  ),
                )
              ],
            );
          })),
    );
  }
}
