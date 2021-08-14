import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({ Key? key }) : super(key: key);

  @override
  NavigatorPageState createState() => NavigatorPageState();
}

class NavigatorPageState extends State<NavigatorPage> {

  AuthMethods authMethods = AuthMethods();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator Page', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => signOut()
          )
        ],
      ),
      body: Center(
        child: Text('Is Shop: ${UserConstants.isShop}\nEmail: ${UserConstants.email}'),
      ),
    );
  }
}