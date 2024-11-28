import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

import '../../main.dart';

class ScannerScreen extends StatefulWidget {
  final String? deposit;
  const ScannerScreen({super.key, this.deposit});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late CameraController controller;
  int currentCameraIndex = 0;
  late AnimationController animController;
  late Animation<double> _animation;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    initCamera(currentCameraIndex);
    initAnimation();
  }

  initAnimation() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(animController);
  }

  Future<void> initCamera(currentCameraIndex) async {
    controller = CameraController(
      cameras[currentCameraIndex],
      ResolutionPreset.max,
    );
    await controller.initialize();
    setState(() {});
  }

  void _switchCamera() async {
    if (cameras.length < 2) {
      log('No other camera available to switch.');
      return;
    }

    currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
    log('currentCameraIndex: $currentCameraIndex');

    await controller.dispose();

    await initCamera(currentCameraIndex);

    if (animController.status == AnimationStatus.completed) {
      animController.forward();
    }

    setState(() {});
  }

  Future<void> toggleFlashlight() async {
    if (controller.value.isInitialized) {
      if (controller.value.flashMode == FlashMode.off) {
        await controller.setFlashMode(FlashMode.torch);
      } else {
        await controller.setFlashMode(FlashMode.off);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: !controller.value.isInitialized
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeCap: StrokeCap.round,
                ),
              )
            : Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Stack(children: [
                            cameraWidget(context),
                            BackdropFilter(
                              filter:
                                  ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )
                          ]))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 38.0),
                      child: Utils.myBackButton(context),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SizedBox(
                              child: Column(children: [
                                Expanded(
                                  flex: 2,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: size,
                                          height: size,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17),
                                          child: ClipRect(
                                            child: Screenshot(
                                              controller: screenshotController,
                                              child: SizedBox(
                                                width: size,
                                                height: size,
                                                child: cameraWidget(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            Assets.faceFrame,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: AnimatedBuilder(
                                          animation: animController,
                                          builder: (context, child) {
                                            final currentPosition =
                                                110 * _animation.value;

                                            final isAtTop =
                                                currentPosition <= -110;
                                            final isAtBottom =
                                                currentPosition >= 110;

                                            final flip = (isAtTop || isAtBottom)
                                                ? 3.14159
                                                : 0.0;

                                            return Transform.translate(
                                              offset:
                                                  Offset(0, currentPosition),
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(flip),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: Image.asset(
                                              Assets.shaderVector,
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${LocaleKeys.centerFace.tr()} ${widget.deposit == 'yes' ? LocaleKeys.qrCode.tr() : LocaleKeys.face.tr()}',
                                        style: Styles.appBarTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: widget.deposit != 'yes'
                                            ? Text(
                                                LocaleKeys.pointFaceRight.tr(),
                                                style: Styles.regularText
                                                    .copyWith(
                                                        color: Colors.white),
                                                textAlign: TextAlign.center,
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.deposit != 'yes'
                                                ? GestureDetector(
                                                    onTap: _switchCamera,
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffA8A8A8)),
                                                      child: Image.asset(
                                                          Assets.cameraRotate),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _captureImage(context);
                                              },
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffA8A8A8)),
                                                child: Image.asset(
                                                    Assets.checkedIcon),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            GestureDetector(
                                              onTap: toggleFlashlight,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffA8A8A8),
                                                    shape: BoxShape.circle),
                                                child: Image.asset(
                                                  Assets.torchIcon,
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }

  Widget cameraWidget(context) {
    var camera = controller.value;

    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * camera.aspectRatio;

    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(controller),
      ),
    );
  }

  Future<void> _captureImage(BuildContext context) async {
    try {
      Uint8List? image = await screenshotController.capture(pixelRatio: 1.0);
      if (image != null) {
        log('Screenshot captured successfully');
        if (widget.deposit == 'yes') {
          if (context.mounted) {
            context.pushNamed(Routes.depositAmountScreen,
                pathParameters: {'depositCode': '0212'});
          }
        } else {
          if (context.mounted) {
            context.goNamed(
              Routes.otpScreen,
              pathParameters: {
                'isImageVerification': 'true',
                'isPasswordChanged': 'false',
                'value': 'value',
              },
            );
          }
        }
      } else {
        log('Screenshot capture returned null');
      }
    } catch (e) {
      log('Error capturing image: $e');
    }
  }
}
