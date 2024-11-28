import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamapay_shop_app/router/router.dart';
import 'package:zamapay_shop_app/states/image_picker_state.dart';
import 'package:zamapay_shop_app/states/otp_timer_provider.dart';
import 'package:zamapay_shop_app/states/theme_state.dart';
import 'package:zamapay_shop_app/styles/dark_theme.dart';
import 'package:zamapay_shop_app/styles/light_theme.dart';
import 'package:zamapay_shop_app/utils/shared_pref.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  cameras = await availableCameras();
  SharedPref.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('af', 'ZA'),
        Locale('es', 'ES'),
        Locale('fr', 'FR'),
      ],
      saveLocale: true,
      path: 'assets/l10n',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OTPTimeProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerState()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return MaterialApp.router(
          title: 'Zamapay',
          themeMode:
              provider.themeMode, // Access the themeMode from the provider
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: routerConfiguration,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      }),
    );
  }
}
