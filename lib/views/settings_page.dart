// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key key }) : super(key: key);

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
                fontSize: 50,
                color: AppColors.lightTheme,
                fontFamily: 'Nunito-Bold'
              ),
            ),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.lightTheme,
                fontFamily: 'Nunito-Bold'
              ),
            ),            
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              alignment: Alignment.center,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => print(UserConstants.imgUrl),
                    child: Container(
                      child: UserConstants.imgUrl == ''
                        ? CircleAvatar(
                            backgroundImage: AssetImage('assets/images/account_image.png'),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          )
                        : CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(UserConstants.imgUrl),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    UserConstants.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito-Bold',
                      color: AppColors.lightTheme
                    ),
                  ),
                  Text(
                    UserConstants.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito-Bold',
                      color: AppColors.lightTheme
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'More Settings',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Nunito-Bold',
                color: AppColors.lightTheme
              ),
            ),
            SizedBox(height: 24,),
            SettingsTile(icon: Icons.dark_mode, color1: Colors.purple[800], color2: Colors.purple[200], title: 'Dark Mode',),
            SizedBox(height: 24,),
            SettingsTile(icon: Icons.info, color1: Colors.green[800], color2: Colors.green[200], title: 'About Me',),
            SizedBox(height: 24,),
            SettingsTile(icon: Icons.logout, color1: Colors.red[800], color2: Colors.red[200], title: 'Logout',),            
          ],
        ),
      ),
    );
  }
}