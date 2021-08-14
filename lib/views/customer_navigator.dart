import 'package:flutter/material.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({ Key? key }) : super(key: key);

  @override
  NavigatorPageState createState() => NavigatorPageState();
}

class NavigatorPageState extends State<NavigatorPage> {

  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Nav Page', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await authMethods.signOut();
              Navigator.pushReplacement(context, PageTransition(
                child: SignIn(),
                type: PageTransitionType.leftToRightWithFade
              ));
            }
          )
        ],
      ),
      body: Center(
        child: Text('Customer home page'),
      ),
    );
  }
}