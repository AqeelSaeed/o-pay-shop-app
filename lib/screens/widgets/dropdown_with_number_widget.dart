import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class BankWithNumberDropDownComponent extends StatefulWidget {
  final List<Map<String, String>> banks; // List of banks and accounts
  final String? selectedBank; // Initially selected bank
  final ValueChanged<String?> onChanged; // Callback when a new bank is selected
  final String? defaultLogo; // Default bank logo in case one is not provided

  const BankWithNumberDropDownComponent(
      {super.key,
      required this.banks,
      this.selectedBank,
      required this.onChanged,
      required this.defaultLogo});

  @override
  State<BankWithNumberDropDownComponent> createState() =>
      _BankWithNumberDropDownComponentState();
}

class _BankWithNumberDropDownComponentState
    extends State<BankWithNumberDropDownComponent> {
  String? selectedBank;

  @override
  void initState() {
    super.initState();
    selectedBank = widget.selectedBank; // Initialize selected bank
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedBank,
        dropdownColor: Colors.white,
        underline: const SizedBox(),
        icon: Image.asset(
          Assets.dropDownIcon,
          color: mediumBlack,
          height: 10,
        ),
        hint: Text(
          'Select Bank',
          style: Styles.regularText.copyWith(color: mediumGrey),
        ),
        items: widget.banks.map((bank) {
          return DropdownMenuItem<String>(
            value: bank['name'],
            child: Row(
              children: [
                // Use provided bank logo if available
                SizedBox(
                  height: 30,
                  width: 40,
                  child: Image.asset(
                    bank['logo'] ?? Assets.bankIcon,
                    height: 35, // Fixed height for logo
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank['name']!,
                      style: Styles.regularText
                          .copyWith(color: mediumBlack, fontSize: 15),
                    ),
                    Text(bank['account']!,
                        style: Styles.regularText
                            .copyWith(color: mediumGrey, fontSize: 13)),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedBank = newValue;
          });
          widget.onChanged(newValue); // Notify the parent widget
        },
      ),
    );
  }
}
