// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocs/models/theme_model.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/splash_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeModel>(
    create: (_) => ThemeModel(),
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: SplashScreen(),
    );
  }
}