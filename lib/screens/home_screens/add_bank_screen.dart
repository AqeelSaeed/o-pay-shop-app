import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_appbar.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_text_field.dart';
import 'package:zamapay_shop_app/screens/widgets/dropdown_component.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String? selectedBank;

  List<String> dropItems = [
    'National Bank',
    'Al-Rajhi Bank',
    'Bank of America'
  ];

  @override
  void dispose() {
    accountNameController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Add Bank',
        leadingAsset: Assets.backButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            DropdownComponent(
              title: 'Select Bank',
              items: dropItems,
              value: selectedBank,
              hint: 'Select Bank',
              labelBuilder: (label) => label,
              prefixIcon: Assets.bankIcon,
              onChanged: (value) {
                setState(() => selectedBank = value);
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Account Number',
              controller: accountNumberController,
              prefixIconPath: Assets.creditCardIcon,
              hintText: '1234 5678 8765 4321',
              prefixColor: primaryColor,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Account Name',
              controller: accountNameController,
              prefixIconPath: Assets.userIcon,
              hintText: 'John Doe',
              prefixColor: primaryColor,
            ),
            const Spacer(),
            CustomButton(
              text: 'Save',
              onPressed: () {},
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
