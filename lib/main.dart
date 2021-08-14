import 'package:flutter/material.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.orange,
        fontFamily: 'Nunito-SemiBold'
      ),
      home: SignIn(),
    );
  }
}