import 'package:bcm_alpha_app/screens/contract_info_screen.dart';
import 'package:bcm_alpha_app/screens/contracts_tabs.dart';
import 'package:bcm_alpha_app/screens/dividends_screen.dart';
import 'package:bcm_alpha_app/screens/investment_contract.dart';
import 'package:bcm_alpha_app/screens/investment_success_screen.dart';
import 'package:bcm_alpha_app/screens/investments_screen.dart';
import 'package:bcm_alpha_app/screens/latest_payouts_screen.dart';
import 'package:bcm_alpha_app/screens/login_screen.dart';
import 'package:bcm_alpha_app/screens/packages_tabs.dart';
import 'package:bcm_alpha_app/screens/payments_tabs.dart';
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
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCM Application',
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
        LatestPayoutsScreen.routeName: (ctx) => LatestPayoutsScreen(),
        DividendsScreen.routeName: (ctx) => DividendsScreen(),
        ReportsScreen.routeName: (ctx) => ReportsScreen(),
        TransactionHistory.routeName: (ctx) => TransactionHistory(),
        InvestmentSuccessScreen.routeName: (ctx) => InvestmentSuccessScreen(),
        ContractInfo.routeName: (ctx) => ContractInfo(),
        ContractsTabs.routeName: (ctx) => ContractsTabs(),
        InvestmentContract.routeName: (ctx) => InvestmentContract(),
        PackagesTabs.routeName: (ctx) => PackagesTabs(),
        PaymentsTabs.routeName: (ctx) => PaymentsTabs()
      },
    );
  }
}
