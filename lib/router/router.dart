import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/screens/auth_screens/activation_completed.dart';
import 'package:zamapay_shop_app/screens/auth_screens/scanner_screen.dart.dart';
import 'package:zamapay_shop_app/screens/auth_screens/forgot_password/forgot_password_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/forgot_password/new_password_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/forgot_password/otp_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/forgot_password/result_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/login_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/onBoarding/on_boarding_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/signup_screen/signup_screen.dart';
import 'package:zamapay_shop_app/screens/auth_screens/terms_and_conditions_screen.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/bottom_navigation_widget.dart';
import 'package:zamapay_shop_app/screens/dashboard/analytics_screen.dart';
import 'package:zamapay_shop_app/screens/dashboard/history_screen.dart';
import 'package:zamapay_shop_app/screens/dashboard/home_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/add_bank_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/confirmation/confirmation_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/deposit_funds/deposit_amount_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/deposit_funds/deposit_funds_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/make_transfer_amount_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/make_a_transfer_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/deposit_funds/transfer_funds_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/transfer_recoincilation_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/utility_bill_screens/bill_amount_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/utility_bill_screens/bill_reference_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/utility_bill_screens/utility_bill_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/pay_for_transfer_amount_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/pay_a_transfer_screens/amount_input_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/pay_a_transfer_screens/pay_for_transfer_screen.dart';
import 'package:zamapay_shop_app/screens/home_screens/pay_a_transfer_screens/withdraw_slider.dart';
import 'package:zamapay_shop_app/screens/dashboard/profile_screen.dart';
import 'package:zamapay_shop_app/screens/profile_screens/change_password_screen.dart';
import 'package:zamapay_shop_app/screens/profile_screens/contact_support.dart';
import 'package:zamapay_shop_app/screens/profile_screens/help_center_screen.dart';
import 'package:zamapay_shop_app/screens/profile_screens/language_screen.dart';
import 'package:zamapay_shop_app/screens/profile_screens/my_account_screen.dart';
import 'package:zamapay_shop_app/screens/dashboard/notification_screen.dart';
import 'package:zamapay_shop_app/screens/profile_screens/themes_screen.dart';
import 'package:zamapay_shop_app/screens/widgets/transaction_success.dart';
import 'package:zamapay_shop_app/screens/splash_screen.dart';
import 'package:zamapay_shop_app/screens/topup_screen/topup_screen.dart';
import 'package:zamapay_shop_app/screens/transactions_screen/transactions_screen.dart';
import 'package:zamapay_shop_app/utils/enums.dart';
import 'package:zamapay_shop_app/utils/snippets.dart';

import '../screens/home_screens/reconciliation_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
// Define unique navigator keys for each branch
final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> analyticsNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> erpNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> groupsNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> profileNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter routerConfiguration = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splashScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.onBoarding,
      name: Routes.onBoarding,
      builder: (BuildContext context, GoRouterState state) {
        return const OnBoardingScreen();
      },
    ),
    GoRoute(
      path: Routes.loginScreen,
      name: Routes.loginScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.signupScreen,
      name: Routes.signupScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path:
          '${Routes.otpScreen}/:isImageVerification/:isPasswordChanged/:value',
      name: Routes.otpScreen,
      builder: (BuildContext context, GoRouterState state) {
        log(state.pathParameters.toString());
        final imageVerificationStatus =
            state.pathParameters['isImageVerification'];
        final passwordChangeStatus = state.pathParameters['isPasswordChanged'];
        final value = state.pathParameters['value'];
        return OTPScreen(
          isImageVerification: imageVerificationStatus ?? '',
          isPasswordChanged: passwordChangeStatus ?? '',
          value: value,
        );
      },
    ),
    GoRoute(
      path: '${Routes.scannerScreen}/:deposit',
      name: Routes.scannerScreen,
      builder: (BuildContext context, GoRouterState state) {
        final String deposit = state.pathParameters['deposit'] ?? '';
        return ScannerScreen(
          deposit: deposit,
        );
      },
    ),
    GoRoute(
      path: Routes.forgotPasswordSreen,
      name: Routes.forgotPasswordSreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordScreen();
      },
    ),
    GoRoute(
      path: Routes.newPasswordScreen,
      name: Routes.newPasswordScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const NewPasswordScreen();
      },
    ),
    GoRoute(
      path: '${Routes.resultScreen}/:isImageVerified/:isPasswordChanged',
      name: Routes.resultScreen,
      builder: (BuildContext context, GoRouterState state) {
        final isImageVerification = state.pathParameters['isImageVerified'];
        final isPasswordChanged = state.pathParameters['isPasswordChanged'];
        return ResultScreen(
            isImageVerified: isImageVerification ?? '',
            isPasswordChanged: isPasswordChanged ?? '');
      },
    ),
    GoRoute(
      path: Routes.termsAndConditionsScreen,
      name: Routes.termsAndConditionsScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TermsAndConditions();
      },
    ),
    GoRoute(
      path: Routes.activationCompletedScreen,
      name: Routes.activationCompletedScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ActivationCompleted();
      },
    ),
    // GoRoute(
    //   path: Routes.dashboardScreen,
    //   name: Routes.dashboardScreen,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const DashboardScreen();
    //   },
    //   routes: const <RouteBase>[],
    // ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigtionShell) {
          return BottomNavigationWidget(navigationShell: navigtionShell);
        },
        branches: [
          StatefulShellBranch(
              navigatorKey: homeNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.homeScreen,
                  path: Routes.homeScreen,
                  builder: (context, state) => const HomeScreen(),
                ),
              ]),
          StatefulShellBranch(
              navigatorKey: analyticsNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: Routes.analyticsScreen,
                    builder: (context, state) => const AnalyticsScreen()),
              ]),
          StatefulShellBranch(
              navigatorKey: erpNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: Routes.notificationScreen,
                    builder: (context, state) => const NotificationScreen()),
              ]),
          StatefulShellBranch(
              navigatorKey: groupsNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: Routes.historyScreen,
                    builder: (context, state) => const HistoryScreen()),
              ]),
          StatefulShellBranch(
              navigatorKey: profileNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: Routes.profileScreen,
                    builder: (context, state) => const ProfileScreen()),
              ]),
        ]),

    GoRoute(
      path: Routes.profileScreen,
      name: Routes.profileScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: Routes.myAccountScreen,
      name: Routes.myAccountScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const MyAccountScreen();
      },
    ),
    GoRoute(
      path: Routes.changePasswordScreen,
      name: Routes.changePasswordScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePasswordScreen();
      },
    ),
    GoRoute(
      path: Routes.notificationScreen,
      name: Routes.notificationScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationScreen();
      },
    ),
    GoRoute(
      path: Routes.themesScreen,
      name: Routes.themesScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ThemesScreen();
      },
    ),
    GoRoute(
      path: Routes.languageScreen,
      name: Routes.languageScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const LanguageScreen();
      },
    ),
    GoRoute(
      path: Routes.helpCenterScreen,
      name: Routes.helpCenterScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpCenterScreen();
      },
    ),
    GoRoute(
      path: Routes.contactSupportScreen,
      name: Routes.contactSupportScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ContactSupport();
      },
    ),
    GoRoute(
      path: '${Routes.depositScreen}/:screenType',
      name: Routes.depositScreen,
      builder: (BuildContext context, GoRouterState state) {
        final String type = state.pathParameters['screenType'] ?? '';
        return DepositFundsScreen(
          screenType: type,
        );
      },
    ),
    GoRoute(
      path: '${Routes.payForTransferAmountScreen}/:transferCode',
      name: Routes.payForTransferAmountScreen,
      builder: (BuildContext context, GoRouterState state) {
        final code = state.pathParameters['transferCode'];
        return PayForTransferAmountScreen(
          transferCode: double.parse(code.toString()),
        );
      },
    ),
    GoRoute(
      path: Routes.addBankScreen,
      name: Routes.addBankScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const AddBankScreen();
      },
    ),
    GoRoute(
      path: Routes.transferFundsScren,
      name: Routes.transferFundsScren,
      builder: (BuildContext context, GoRouterState state) {
        return const TransferFundsScreen();
      },
    ),
    GoRoute(
      path: Routes.transferRecoinciliationsScreen,
      name: Routes.transferRecoinciliationsScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TransferRecoincilationScreen();
      },
    ),
    GoRoute(
      path: Routes.topupScreen,
      name: Routes.topupScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TopupScreen();
      },
    ),
    GoRoute(
      path: Routes.reconciliationsScreen,
      name: Routes.reconciliationsScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const ReconciliationScreen();
      },
    ),
    GoRoute(
      path: Routes.transactionsScreen,
      name: Routes.transactionsScreen,
      builder: (BuildContext context, GoRouterState state) {
        return TransactionsScreen(
            transactions: state.extra as List<TransactionHistoryModel>);
      },
    ),
    GoRoute(
      path: '${Routes.confirmationScreen}/:confirmAmount',
      name: Routes.confirmationScreen,
      builder: (BuildContext context, GoRouterState state) {
        final amount = state.pathParameters['confirmAmount'];
        return ConfirmationScreen(
          confirmAmount: double.parse(amount ?? ''),
        );
      },
    ),
    GoRoute(
      path: Routes.transactionSuccess,
      name: Routes.transactionSuccess,
      builder: (BuildContext context, GoRouterState state) {
        return TransactionSuccess();
      },
    ),
    GoRoute(
      path: Routes.enterWithdrawAmountScreen,
      name: Routes.enterWithdrawAmountScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const AmountInputScreen();
      },
    ),
    GoRoute(
      path: '${Routes.withDrawSliderScreen}/:amount/:transactionType',
      name: Routes.withDrawSliderScreen,
      builder: (BuildContext context, GoRouterState state) {
        final amount = state.pathParameters['amount'];
        final String? transactionType = state.pathParameters['transactionType'];
        log('transTypeRoute:$transactionType');
        // Remove the 'BillType.' prefix if present
        final String? formattedBillTypeString =
            transactionType?.replaceFirst('TransactionType.', '');
        log('formattedBillType:$formattedBillTypeString');
        // Convert the cleaned string to a BillType enum
        final TransactionType? billType =
            mapStringToTransactionType(formattedBillTypeString);

        log('Mapped billType: $billType');

        if (billType == null) {
          // Handle the case where the bill type is invalid or null
          return Container(
            color: Colors.orange,
            child: const Center(
              child: Text(
                'No Screen Found',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          );
        }

        return WithdrawSlider(
          amount: double.parse(amount ?? ''),
          transactionType: billType,
        );
      },
    ),
    GoRoute(
      // path: '${Routes.transferDetailsScreen}/:typeOfFunds',
      path: Routes.transferDetailsScreen,
      name: Routes.transferDetailsScreen,
      builder: (BuildContext context, GoRouterState state) {
        // final typeOfFunds = state.pathParameters['typeOfFunds'];
        return const MakeTransferScreen(
            // typeOfFunds: typeOfFunds ?? '',
            );
      },
    ),
    GoRoute(
      path: Routes.transferAmountScreen,
      name: Routes.transferAmountScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const TransferAmountScreen();
      },
    ),
    GoRoute(
      path: '${Routes.billAmountScreen}/:billType',
      name: Routes.billAmountScreen,
      builder: (BuildContext context, GoRouterState state) {
        final String? billTypeString = state.pathParameters['billType'];
        log('bilTypeRoute:$billTypeString');
        // Remove the 'BillType.' prefix if present
        final String? formattedBillTypeString =
            billTypeString?.replaceFirst('BillType.', '');

        // Convert the cleaned string to a BillType enum
        final TransactionType? billType =
            mapStringToTransactionType(formattedBillTypeString);

        log('Mapped billType: $billType');

        if (billType == null) {
          // Handle the case where the bill type is invalid or null
          return Container(
            color: Colors.orange,
            child: const Center(
              child: Text(
                'No Screen Found',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          );
        }
        return BillAmountScreen(
          billType: billType,
        );
      },
    ),
    GoRoute(
      path: '${Routes.utilityBillScreen}/:billType',
      name: Routes.utilityBillScreen,
      builder: (BuildContext context, GoRouterState state) {
        final String? billTypeString = state.pathParameters['billType'];
        log('bilTypeRoute:$billTypeString');
        // Remove the 'BillType.' prefix if present
        final String? formattedBillTypeString =
            billTypeString?.replaceFirst('BillType.', '');

        // Convert the cleaned string to a BillType enum
        final BillType? billType = mapStringToBillType(formattedBillTypeString);

        log('Mapped billType: $billType');

        if (billType == null) {
          // Handle the case where the bill type is invalid or null
          return Container(
            color: Colors.orange,
            child: const Center(
              child: Text(
                'No Screen Found',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          );
        }

        return UtilityBillScreen(billType: billType);
      },
    ),

    GoRoute(
      path: '${Routes.billReferenceScreen}/:billType',
      name: Routes.billReferenceScreen,
      builder: (BuildContext context, GoRouterState state) {
        final String? billTypeString = state.pathParameters['billType'];
        log('bilTypeRoute:$billTypeString');
        // Remove the 'BillType.' prefix if present
        final String? formattedBillTypeString =
            billTypeString?.replaceFirst('BillType.', '');

        // Convert the cleaned string to a BillType enum
        final BillType? billType = mapStringToBillType(formattedBillTypeString);

        log('Mapped billType: $billType');

        if (billType == null) {
          // Handle the case where the bill type is invalid or null
          return Container(
            color: Colors.orange,
            child: const Center(
              child: Text(
                'No Screen Found',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          );
        }

        return BillReferenceScreen(billType: billType);
      },
    ),
    GoRoute(
      path: Routes.payForTransferScreen,
      name: Routes.payForTransferScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const PayForTransferScreen();
      },
    ),
    GoRoute(
      path: '${Routes.depositAmountScreen}/:depositCode',
      name: Routes.depositAmountScreen,
      builder: (BuildContext context, GoRouterState state) {
        final code = state.pathParameters['depositCode'] ?? '';
        return DepositAmountScreen(
          depositCode: double.parse(code),
        );
      },
    ),
  ],
);

class Routes {
  static const String splashScreen = '/';
  static const String onBoarding = '/on_boarding_screen';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';
  static const String otpScreen = '/otp_screen';
  static const String scannerScreen = '/scannerScreen';
  static const String forgotPasswordSreen = '/forgot_password_screen';
  static const String newPasswordScreen = '/new_password_screen';
  static const String resultScreen = '/result_screen';
  static const String termsAndConditionsScreen = '/terms_and_conditions';
  static const String activationCompletedScreen = '/activation_completed';

  ///================== Transaction Flow Screens =========================================
  static const String depositScreen = '/depositScreen';
  static const String payForTransferAmountScreen =
      '/payForTransferAmountScreen';
  static const String addBankScreen = '/addBankScreen';
  static const String transferFundsScren = '/tansferFundsScreen';
  static const String transferRecoinciliationsScreen =
      '/transferRecoinciliationsScreen';
  static const String topupScreen = '/topupScreen';
  static const String reconciliationsScreen = '/reconciliationsScreen';
  static const String transactionsScreen = '/transactionsScreen';
  static const String confirmationScreen = '/confirmationScreen';
  static const String transactionSuccess = '/transactionSuccess';
  static const String enterWithdrawAmountScreen = '/enter-amount-withdraw';
  static const String withDrawSliderScreen = '/withdrawSlideScreen';
  static const String transferDetailsScreen = '/transferDetailsScreen';
  static const String transferAmountScreen = '/transferAmountScreen';
  static const String utilityBillScreen = '/utilityBillScreen';
  static const String billReferenceScreen = '/billReferenceScreen';
  static const String billAmountScreen = '/billAmountScreen';
  static const String payForTransferScreen = '/payForTransferScreen';
  static const String depositAmountScreen = '/depositAmountScreen';

  static const String homeScreen = '/homeScreen';
  static const String analyticsScreen = '/analyticsScreen';
  static const String historyScreen = '/historyScreen';
  // ================ child Routes for bottom navigation screens ======================
  static const String profileScreen = '/profileScreen';
  static const String myAccountScreen = '/my_account_screen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String themesScreen = '/themesScreen';
  static const String languageScreen = '/languageScreen';
  static const String helpCenterScreen = '/helpCenter';
  static const String contactSupportScreen = '/contactSupport';
  static const String fontSizeScreen = '/fontSizeScreen';
}
