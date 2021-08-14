// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primaryColor: AppColors.lightTheme,
        fontFamily: 'Nunito-SemiBold'
      ),
      home: SplashScreen(),
    );
  }
}