import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 50
              ),
            ),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 30
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/account_image.png'),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  Text(
                    UserConstants.name,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(
                    UserConstants.email,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'More Settings',
              style: TextStyle(
                fontSize: 30
              ),
            ),
            SettingsTile(icon: Icons.dark_mode, color: Colors.purple[800], title: 'Dark Mode',),
            SettingsTile(icon: Icons.info, color: Colors.green[800], title: 'About Me',),
            SettingsTile(icon: Icons.logout, color: Colors.red[800], title: 'Logout',),            
          ],
        ),
      ),
    );
  }
}