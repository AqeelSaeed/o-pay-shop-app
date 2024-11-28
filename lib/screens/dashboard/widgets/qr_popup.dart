import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zamapay_shop_app/screens/widgets/custom_button.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/colors.dart';

class QrPopup extends StatefulWidget {
  const QrPopup({super.key});

  @override
  State<QrPopup> createState() => _QrPopupState();
}

class _QrPopupState extends State<QrPopup> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? darkTileColor
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          surfaceTintColor: Theme.of(context).brightness == Brightness.dark
              ? darkTileColor
              : Colors.white,
          color: Theme.of(context).brightness == Brightness.dark
              ? darkTileColor
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Roberto - 0032',
                  style: Styles.regularMediumBlackStyle(context)
                      .copyWith(fontSize: 16)),
              const SizedBox(height: 20),
              Screenshot(
                controller: screenshotController,
                child: SizedBox(
                  height: 183,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          Icons.qr_code_2,
                          size: 150,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                borderRadius: 10,
                text: 'Share',
                textColor: Colors.white,
                color: primaryColor,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _shareQrCode() async {
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   screenshotController.capture().then((Uint8List? image) async {
  //     if (image != null) {
  //       try {
  //         String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  //         final imagePath = await File('$directory/$fileName.png').create();
  //         await imagePath.writeAsBytes(image);
  //         Share.shareXFiles([XFile(imagePath.path)]);
  //       } catch (error) {
  //         //
  //       }
  //     }
  //   }).catchError((onError) {
  //     print('Error --->> $onError');
  //   });
  // }
}
