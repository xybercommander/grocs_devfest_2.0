import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';

class CustomerMainPage extends StatefulWidget {
  const CustomerMainPage({ Key? key }) : super(key: key);

  @override
  _CustomerMainPageState createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Is Shop: ${UserConstants.isShop}\nEmail: ${UserConstants.email}'),
      ),
    );
  }
}