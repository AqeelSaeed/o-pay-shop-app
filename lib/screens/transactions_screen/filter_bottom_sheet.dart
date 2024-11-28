import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/snippets.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    amountController.dispose();
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
                LocaleKeys.filters.tr(),
                style: Styles.regularMediumBlackStyle(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Positioned(
                right: 16,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      startDateController.clear();
                      endDateController.clear();
                      amountController.clear();
                    });
                  },
                  child: Text(
                    LocaleKeys.reset.tr(),
                    style: Styles.regularMediumBlackStyle(context),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                controller: startDateController,
                labelText: LocaleKeys.selectDate.tr(),
                prefixIconPath: Assets.calendarIcon,
                prefixColor: primaryColor,
                hintText: startDate == null ? LocaleKeys.selectDate.tr() : '',
                onTap: () async {
                  startDate = await showDateDialog(context, date: startDate);
                  if (startDate != null) {
                    startDateController.text = formatDate(startDate!);
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: amountController,
                hintText: LocaleKeys.addAmount.tr(),
                labelText: LocaleKeys.addAmount.tr(),
                prefixIconPath: Assets.amonutIcon,
                prefixColor: primaryColor,
                inputType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: endDateController,
                labelText: LocaleKeys.selectDate.tr(),
                prefixIconPath: Assets.receiptIcon,
                prefixColor: primaryColor,
                hintText: endDate == null ? LocaleKeys.selectDate.tr() : '',
                onTap: () async {
                  endDate = await showDateDialog(context, date: endDate);
                  if (endDate != null) {
                    endDateController.text = formatDate(endDate!);
                  }
                },
              ),
              const SizedBox(height: 100),
              CustomButton(
                text: LocaleKeys.applyFilters.tr(),
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
