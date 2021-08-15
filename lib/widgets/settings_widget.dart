// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:grocs/models/theme_model.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/widgets/theme_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String title;  
  const SettingsTile({ 
    Key key, 
    @required this.color, 
    @required this.title, 
    @required this.icon 
  }) : super(key: key);

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {

  AuthMethods authMethods = AuthMethods();
  bool darkMode = false;
  ThemeData themeData;

  signOut() async{
    await authMethods.signOut();
    SharedPref.saveEmailSharedPreference("");
    SharedPref.saveNameSharedPreference("");
    SharedPref.saveLoggedInSharedPreference(false);

    Navigator.pushReplacement(context, PageTransition(
      child: SignIn(),
      type: PageTransitionType.leftToRightWithFade
    ));
  }

  @override
  void initState() {
    themeData = Provider.of<ThemeModel>(context, listen: false).currentTheme;
    if(themeData == darkTheme) {
      setState(() {
        darkMode = true;
      });
    } else {
      setState(() {
        darkMode = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(50)
          ),
          child: Center(
            child: Icon(widget.icon, color: widget.color,),
          ),
        ),
        SizedBox(width: 12,),
        Text(widget.title, style: TextStyle(fontSize: 18),),
        Spacer(),
        Container(
          child: widget.title == 'Dark Mode'
            ? FlutterSwitch(
                      width: 70.0,
                      height: 40.0,
                      toggleSize: 45.0,
                      value: darkMode,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: Color(0xFF6E40C9),
                      inactiveToggleColor: Color(0xFF2F363D),
                      activeSwitchBorder: Border.all(
                        color: Color(0xFF3C1E70),
                        width: 4.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Color(0xFFD1D5DA),
                        width: 4.0,
                      ),
                      activeColor: Color(0xFF271052),
                      inactiveColor: Colors.white,
                      activeIcon: Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFF8E3A1),
                      ),
                      inactiveIcon: Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFDF5D),
                      ),
                      onToggle: (val) {
                        setState(() {
                          darkMode = val; 
                          Provider.of<ThemeModel>(context, listen: false).toggleTheme();
                        });
                      },
                    )
            : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      if(widget.title == 'Logout') {
                        signOut();
                      }
                    },
                    icon: Icon(Icons.keyboard_arrow_right),
                  )
                ),
              ),
        )
      ],
    );    
  }
}