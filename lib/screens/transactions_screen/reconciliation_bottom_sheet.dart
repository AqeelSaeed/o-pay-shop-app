import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class ReconciliationBottomSheet extends StatefulWidget {
  const ReconciliationBottomSheet({super.key});

  @override
  State<ReconciliationBottomSheet> createState() =>
      _ReconciliationBottomSheetState();
}

class _ReconciliationBottomSheetState extends State<ReconciliationBottomSheet> {
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController customerAmount = TextEditingController();
  final TextEditingController agentController = TextEditingController();
  @override
  void dispose() {
    bankAccountController.dispose();
    customerAmount.dispose();
    agentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DragHandle(),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
              Text(
                LocaleKeys.reconciliation.tr(),
                style: Styles.regularMediumBlackStyle(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                controller: bankAccountController,
                labelText: LocaleKeys.customerBankAccount.tr(),
                hintText: '12345-XXXX XXXX',
                prefixIconPath: Assets.cardIcon,
                prefixColor: primaryColor,
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: customerAmount,
                labelText: LocaleKeys.customerAmount.tr(),
                hintText: LocaleKeys.customerAmount.tr(),
                prefixIconPath: Assets.amonutIcon,
                prefixColor: primaryColor,
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: agentController,
                labelText: LocaleKeys.agentAmount.tr(),
                hintText: LocaleKeys.agentAmount.tr(),
                prefixIconPath: Assets.amonutIcon,
                prefixColor: primaryColor,
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 100),
              CustomButton(
                text: LocaleKeys.done.tr(),
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5,
        width: 70,
        margin: const EdgeInsets.only(top: 15, bottom: 30),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
