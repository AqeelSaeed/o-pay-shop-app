import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/screens/home_screens/confirmation/confirmation_screen.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import '../../utils/assets_constants.dart';
import '../../utils/snippets.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/network_image_component.dart';
import '../widgets/numpad_widget.dart';
import 'package:go_router/go_router.dart';

class EnterTopupNumberScreen extends StatefulWidget {
  final bool isPostpaid;

  const EnterTopupNumberScreen({super.key, required this.isPostpaid});

  @override
  State<EnterTopupNumberScreen> createState() => _EnterTopupNumberScreenState();
}

class _EnterTopupNumberScreenState extends State<EnterTopupNumberScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.enterNumber.tr(),
        leadingAsset: Assets.backButton,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: NetworkImageComponent(
                    url:
                        'https://www.designevo.com/res/templates/thumb_small/white-ladder-and-red-signal.webp',
                    size: 80,
                    backgroundColor: Color(0xFFF0EEEC),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'ARC TELECOM',
                  style: Styles.regularMediumBlackStyle(context)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                CustomTextField(
                  labelText: LocaleKeys.enterPhoneNumber.tr(),
                  controller: controller,
                  fillColor: Colors.white,
                  inputType: TextInputType.none,
                  borderColor: border,
                  hintText: LocaleKeys.minLengthPhoneNumber.tr(),
                ),
                const SizedBox(height: 15),
                Text(
                  LocaleKeys.enterYourPhoneNumber.tr(),
                  style: Styles.regularMediumBlackStyle(context)
                      .copyWith(fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          NumPadWidget(
            maxLength: 11,
            controller: controller,
            onSubmit: () {
              if (widget.isPostpaid) {
                push(
                  context,
                  const ConfirmationScreen(confirmAmount: 4300),
                );
              } else {
                context.pushNamed(Routes.billAmountScreen,
                    pathParameters: {'billType': BillType.internet.toString()});
              }
            },
          ),
        ],
      ),
    );
  }
}
