import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/screens/widgets/selection_screen.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/enums.dart';

// import 'package:shimmer/shimmer.dart';

String? Function(String?) get mandatoryValidator =>
    (String? val) => val?.isEmpty ?? true ? "This field is mandatory" : null;

String? Function(String?) get emailValidator => (String? email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email ?? "")
        ? null
        : "Enter a valid email";

String? Function(String?) get numberValidator =>
    (String? number) => number?.isEmpty ?? true
        ? "This field is mandatory"
        : RegExp(r"^[0-9]*$").hasMatch(number ?? "")
            ? null
            : "Enter a valid number";

void pushNamed(BuildContext context, String routeName) =>
    Navigator.pushNamed(context, routeName);

String? Function(String?) get passwordValidator => (String? password) =>
    (password?.length ?? 0) < 8 ? "Minumum length must be 8 characters" : null;

String? validateConfirmPassword(String password, String? confirm) {
  if (password != confirm) {
    return "Passwords don't match";
  }
  final err = passwordValidator(confirm);
  if (err != null) {
    return err;
  } else {
    return null;
  }
}

Future<T?> push<T>(
  BuildContext context,
  Widget child,
) =>
    Navigator.of(context).push<T>(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));

void replace(BuildContext context, Widget child) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (_) => child));

void pop(BuildContext context) => Navigator.of(context).pop();

void popToMain(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

void snack(BuildContext context, String message, {bool info = true}) {
  debugPrint(message);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 2000),
    backgroundColor: info ? primaryColor : Colors.red.shade600,
    // behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
    ),
  ));
}

// Helper function to map string to BillType enum
BillType? mapStringToBillType(String? billTypeString) {
  switch (billTypeString?.toLowerCase()) {
    case 'electricity':
      return BillType.electricity;
    case 'water':
      return BillType.water;
    case 'gas':
      return BillType.gas;
    case 'internet':
      return BillType.internet;
    default:
      return null; // If the string doesn't match any BillType
  }
}

// Helper function to map string to BillType enum
TransactionType? mapStringToTransactionType(String? transactionTypeString) {
  switch (transactionTypeString?.toLowerCase()) {
    case 'withdraw':
      return TransactionType.withdraw;
    case 'transfer':
      return TransactionType.transfer;
    case 'electricity':
      return TransactionType.electricity;
    case 'gas':
      return TransactionType.gas;
    case 'water':
      return TransactionType.water;
    case 'internet':
      return TransactionType.internet;
    default:
      return null; // If the string doesn't match any BillType
  }
}

// Helper function to get the name of the bill type
String getBillTypeName(BillType billType) {
  switch (billType) {
    case BillType.electricity:
      return LocaleKeys.electricBill.tr();
    case BillType.water:
      return LocaleKeys.waterBill.tr();
    case BillType.gas:
      return LocaleKeys.gasBill.tr();
    case BillType.internet:
      return LocaleKeys.internetBill.tr();
    default:
      return 'Utility Bill';
  }
}

// Helper function to get the list of providers based on the bill type
List<ServiceProvider> getProvidersForBillType(BillType billType) {
  switch (billType) {
    case BillType.electricity:
      return [
        ServiceProvider('Fesco', Assets.fescoLogo),
        ServiceProvider('Gepco', Assets.gepcoLogo),
        ServiceProvider('Hesco', Assets.hescoLogo),
      ];
    case BillType.water:
      return [
        ServiceProvider('Fesco', Assets.fescoLogo),
        ServiceProvider('Gepco', Assets.gepcoLogo),
        ServiceProvider('Hesco', Assets.hescoLogo),
      ];
    case BillType.gas:
      return [
        ServiceProvider('Fesco', Assets.fescoLogo),
        ServiceProvider('Gepco', Assets.gepcoLogo),
        ServiceProvider('Hesco', Assets.hescoLogo),
      ];
    case BillType.internet:
      return [
        ServiceProvider('Fesco', Assets.fescoLogo),
        ServiceProvider('Gepco', Assets.gepcoLogo),
        ServiceProvider('Hesco', Assets.hescoLogo),
      ];
    default:
      return [];
  }
}

Future<Uint8List?> pickImageWeb() async {
  final picker = ImagePicker();
  final pickedImage =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
  final bytes = await pickedImage?.readAsBytes();
  return bytes;
}

Future<File?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  XFile? pickedImage = await picker.pickImage(source: source, imageQuality: 60);

  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    return null;
  }
  // final bytes = await pickedImage!.readAsBytes();
  // return base64Encode(bytes);
}

Future<List<File>> pickMultipleImage(ImageSource source) async {
  List<XFile> picked = await ImagePicker().pickMultiImage(imageQuality: 30);
  final List<File> pickedfiles = [];

  if (picked.isNotEmpty) {
    for (var item in picked) {
      pickedfiles.add(File(item.path));
    }
    return pickedfiles;
  }
  return [];
}

String parseDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

Future<dynamic> showDialogOf(context, Widget child,
    {isDismissible = true}) async {
  showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return child;
      });
}

RoundedRectangleBorder getRoundShape({double? val}) =>
    RoundedRectangleBorder(borderRadius: getRoundBorder(val: val));

BorderRadius getRoundBorder({double? val}) => BorderRadius.circular(val ?? 30);
Widget getLoader() =>
    const Center(child: CircularProgressIndicator(color: primaryColor));

void alert(BuildContext context, String message,
    {bool info = false, IconData? icon, String? title}) {
  debugPrint(message);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      actionsPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20) -
          const EdgeInsets.only(top: 40),
      actionsAlignment: MainAxisAlignment.center,
      title: info
          ? Icon(
              icon ?? Icons.check_circle_outline,
              color: Colors.green,
              size: 90,
            )
          : Icon(
              icon ?? Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 90,
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? (info ? "Success" : "Error"),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Okay"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void sureAlert({
  required BuildContext context,
  required String message,
  required void Function() onYes,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 40, horizontal: 120) -
                const EdgeInsets.only(top: 40),
        actionsAlignment: MainAxisAlignment.center,
        title: Icon(
          Icons.help_outline,
          color: Theme.of(context).primaryColor,
          size: 90,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure?",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("Yes"),
            onPressed: () {
              onYes();
              pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text("No"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

Widget getShimmer({double width = 40, height = 12}) {
  return Container(color: Colors.grey, height: height, width: width);
}

bool isKeyboardOpen(BuildContext context) =>
    MediaQuery.of(context).viewInsets.bottom != 0;

Future<String?> alertInput(BuildContext context, String title, String hint,
    {String doneText = "Done"}) async {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(title),
      content: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(hintText: hint),
          controller: controller,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("Cancel", style: TextStyle(color: Colors.orange)),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(doneText),
          onPressed: () => Navigator.of(context).pop(controller.text),
        ),
      ],
    ),
  );
}

int generateRandomNumber({int max = 13}) {
  var rand = Random();
  return rand.nextInt(max);
}

formatNumber(double? number) =>
    NumberFormat("#,###.##", "en_US").format(number);
formatDate(DateTime date) => DateFormat('yMMMd', 'en_US').format(date);
formatTime(DateTime date) => DateFormat("HH:mm").format(date);
formatDateToMonth(DateTime date) =>
    DateFormat('dd-MMM-yyyy', 'en_US').format(date);
formatDateByString(String date) => DateFormat.yMMMMd('en_US').format(
      DateTime(
        int.parse(date[0]),
        int.parse(date[1]),
        int.parse(date[2]),
      ),
    );
// ...

extension DaysAgoExtension on DateTime {
  String daysAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    final days = difference.inDays;

    if (days == 0) {
      return 'Today';
    } else if (days == 1) {
      return 'Yesterday';
    } else {
      return '$days days ago';
    }
  }
}

// Future<String> uploadImage(
//     {required String name,
//     required File image,
//     required Reference reference}) async {
//   final resp = await reference.child('$name.png').putFile(image);
//   return resp.ref.getDownloadURL();
// }

String standardFormatTime(DateTime dataTime) {
  final DateFormat formatter = DateFormat('h:mm a');
  return formatter.format(dataTime);
}

Future<DateTime?> showDateDialog(BuildContext context,
    {required DateTime? date}) async {
  DateTime? pickedDate;
  // if (Platform.isAndroid) {
  pickedDate = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: date ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    locale: const Locale('en', 'US'),
  );
  if (pickedDate != null) {
    return pickedDate;
  }
  // } else {
  // await showCupertinoModalPopup<DateTime?>(
  //   context: context,
  //   builder: (context) => SizedBox(
  //     height: 200,
  //     child: CupertinoDatePicker(
  //       backgroundColor: Colors.white,
  //       mode: CupertinoDatePickerMode.date,
  //       maximumDate: DateTime.now(),
  //       minimumDate: DateTime(1900),
  //       minimumYear: 1900,
  //       initialDateTime: date ?? DateTime.now(),
  //       onDateTimeChanged: (value) => pickedDate = value,
  //     ),
  //   ),
  // );
  // }
  return null;
}
