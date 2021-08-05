import 'package:bcm_alpha_app/screens/contract_info_screen.dart';
import 'package:bcm_alpha_app/screens/dividends_screen.dart';
import 'package:bcm_alpha_app/screens/investment_success_screen.dart';
import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:bcm_alpha_app/screens/latest_payouts_screen.dart';
import 'package:bcm_alpha_app/screens/login_screen.dart';
import 'package:bcm_alpha_app/screens/my_contracts.dart';
import 'package:bcm_alpha_app/screens/register_screen.dart';
import 'package:bcm_alpha_app/screens/reports_screens.dart';
import 'package:bcm_alpha_app/screens/resend_email.dart';
import 'package:bcm_alpha_app/screens/reset_password.dart';
import 'package:bcm_alpha_app/screens/settings_screens/acc_details.dart';
import 'package:bcm_alpha_app/screens/settings_screens/general_settings.dart';
import 'package:bcm_alpha_app/screens/settings_screens/help.dart';
import 'package:bcm_alpha_app/screens/settings_screens/kyc.dart';
import 'package:bcm_alpha_app/screens/settings_screens/privacy_screen.dart';
import 'package:bcm_alpha_app/screens/settings_screens/terms.dart';
import 'package:bcm_alpha_app/screens/shareholder_packages_screen.dart';
import 'package:bcm_alpha_app/screens/tabs_screen.dart';
import 'package:bcm_alpha_app/screens/theme/theme.dart';
import 'package:bcm_alpha_app/screens/transaction_history.dart';
import 'package:bcm_alpha_app/screens/transfer_tabs.dart';
import 'package:bcm_alpha_app/screens/verify_password.dart';
import 'package:bcm_alpha_app/screens/withdrawal_tabs.dart';
import 'package:bcm_alpha_app/screens/withdrawal_view_tabs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCM Application',
      // theme: ThemeData(
      //   //primarySwatch: Colors.blue,
      //   accentColor: Color.fromRGBO(255, 149, 0, 1),
      //   canvasColor: Color.fromRGBO(31, 51, 78, 1),
      //   buttonColor: Colors.white38,
      //   inputDecorationTheme: const InputDecorationTheme(
      //     //labelStyle: TextStyle(color: Colors.black),
      //     hintStyle: TextStyle(color: Colors.white38),
      //   ),
      //   dividerTheme: DividerThemeData(color: Colors.white60),
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.white38),
      //     bodyText2: TextStyle(
      //       color: Colors.white38,
      //     ),
      //     button: TextStyle(color: Colors.white),
      //     caption: TextStyle(color: Colors.white38),
      //     headline1: TextStyle(color: Colors.white38),
      //     headline2: TextStyle(color: Colors.white38),
      //     headline3: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      //     headline4: TextStyle(
      //         color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 25),
      //     headline5: TextStyle(
      //         color: Color.fromRGBO(255, 149, 0, 1),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18),
      //     subtitle1: TextStyle(color: Colors.white, fontSize: 20),
      //     // <-- that's the one
      //     headline6: TextStyle(color: Colors.white, fontSize: 16),
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.white10,
      //     elevation: 5,
      //     margin: EdgeInsets.all(5),
      //   ),
      // ),
      home: LoginScreen(),
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ResetPassword.routeName: (ctx) => ResetPassword(),
        ResendPassword.routeName: (ctx) => ResendPassword(),
        VerifyPassword.routeName: (ctx) => VerifyPassword(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
        ShareholderPackagesScreen.routeName: (ctx) => ShareholderPackagesScreen(),
        InvestmentsScreen.routeName: (ctx) => InvestmentsScreen(),
        WithdrawalsTabs.routeName: (ctx) => WithdrawalsTabs(),
        TransferTabs.routeName: (ctx) => TransferTabs(),
        GeneralSettings.routeName: (ctx) => GeneralSettings(),
        Privacy.routeName: (ctx) => Privacy(),
        Help.routeName: (ctx) => Help(),
        AccountDetails.routeName: (ctx) => AccountDetails(),
        KYC.routeName: (ctx) => KYC(),
        Terms.routeName: (ctx) => Terms(),
        WithdrawalsViewTabs.routeName: (ctx) => WithdrawalsViewTabs(),
        LatestPayoutsScreen.routeName: (ctx) => LatestPayoutsScreen(),
        DividendsScreen.routeName: (ctx) => DividendsScreen(),
        ReportsScreen.routeName: (ctx) => ReportsScreen(),
        TransactionHistory.routeName: (ctx) => TransactionHistory(),
        InvestmentSuccessScreen.routeName: (ctx) => InvestmentSuccessScreen(),
        ContractInfo.routeName: (ctx) => ContractInfo(),
        Contracts.routeName: (ctx) => Contracts(),
      },
    );
  }
}
