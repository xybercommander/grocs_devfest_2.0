// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/navigator_page.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class AuthPage extends StatefulWidget {
  final Stream<QuerySnapshot> userStream;
  const AuthPage({ Key key, this.userStream }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  DocumentSnapshot documentSnapshot;
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.userStream,
        builder: (context, snapshot) {
          if(snapshot.hasData) documentSnapshot = snapshot.data.docs[0];

          Future.delayed(Duration(seconds: 5), () {
            UserConstants.email = documentSnapshot['email'];
            UserConstants.name = documentSnapshot['name'];
            UserConstants.isShop = documentSnapshot['isShop'];

            SharedPref.saveEmailSharedPreference(documentSnapshot['email']);
            SharedPref.saveNameSharedPreference(documentSnapshot['name']);
            SharedPref.saveIsShopSharedPreference(documentSnapshot['isShop']);
            SharedPref.saveLoggedInSharedPreference(true);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, PageTransition(
                child: NavigatorPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 100)
              ));
            });
          });

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/searching.json'),
                Text(
                  'Fetching your data',
                  style: TextStyle(
                    color: AppColors.lightTheme,
                    fontSize: 40,
                    fontFamily: 'Nunito-ExtraBold'
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}