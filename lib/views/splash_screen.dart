import 'package:flutter/material.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  initFunction() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, PageTransition(
        child: SignIn(),
        type: PageTransitionType.fade
      ));
    });
  }

  @override
  void initState() {    
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/shopping_cart.json', height: 300, width: 300),
            Text(
              'Grocs',
              style: TextStyle(
                color: AppColors.lightTheme,
                fontSize: 64,
                fontFamily: 'Nunito-ExtraBold'
              ),
            )
          ],
        ),
      ),
    );
  }
}