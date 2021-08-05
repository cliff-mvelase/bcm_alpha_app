import 'package:bcm_alpha_app/screens/settings_screens/acc_details.dart';
import 'package:bcm_alpha_app/screens/settings_screens/general_settings.dart';
import 'package:bcm_alpha_app/screens/settings_screens/kyc.dart';
import 'package:bcm_alpha_app/screens/settings_screens/terms.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'settingsScreen';

  Widget buildListTile(String title, AssetImage icon, Function tapHandler) {
    return ListTile(
      leading: ImageIcon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        tapHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildListTile(
                'General',
                AssetImage(
                  'assets/images/icons/general_settings_icon.png',
                ), () {
              Navigator.of(context).pushNamed(GeneralSettings.routeName);
            }),
            buildListTile(
                'Account Details',
                AssetImage(
                  'assets/images/icons/acc_settings_icon.png',
                ), () {
              Navigator.of(context).pushNamed(AccountDetails.routeName);
            }),
            buildListTile(
                'KYC',
                AssetImage(
                  'assets/images/icons/kyc_icon.png',
                ), () {
              Navigator.of(context).pushNamed(KYC.routeName);
            }),
            // buildListTile(
            //     'Notifications',
            //     AssetImage(
            //       'assets/images/icons/notifications_icon.png',
            //     ), () {
            //   //Navigator.of(context).pushNamed('/');
            // }),
            // buildListTile(
            //     'Privacy Security',
            //     AssetImage(
            //       'assets/images/icons/security_icon.png',
            //     ), () {
            //   // Navigator.of(context).pushNamed('/');
            // }),
            // buildListTile(
            //     'Help',
            //     AssetImage(
            //       'assets/images/icons/Help_icon.png',
            //     ), () {
            //   //  Navigator.of(context).pushNamed('/');
            // }),
            // buildListTile(
            //     'Terms & Conditions',
            //     AssetImage(
            //       'assets/images/icons/tNc_icon2.png',
            //     ), () {
            //   Navigator.of(context).pushNamed(Terms.routeName);
            // }),
            buildListTile(
                'Log Out',
                AssetImage(
                  'assets/images/icons/logout_icon.png',
                ), () {
              Navigator.of(context).pushNamed('/');
            }),
          ],
        ),
      )),
    );
  }
}
