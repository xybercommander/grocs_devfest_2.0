// @dart=2.9
import 'package:flutter/material.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/profile_type.dart';
import 'package:grocs/views/AuthPages/shop_details.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:page_transition/page_transition.dart';

import '../navigator_page.dart';

class ShopSignUp extends StatefulWidget {
  const ShopSignUp({ Key key }) : super(key: key);

  @override
  _ShopSignUpState createState() => _ShopSignUpState();
}

class _ShopSignUpState extends State<ShopSignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String location;
  
  List<String> locations = ['Kolkata', 'New Delhi', 'Mumbai', 'Chennai'];
  bool hidePassword = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth_bg.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                        child: Text(
                          'Register Your Shop',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Nunito-ExtraBold',
                            color: AppColors.lightTheme,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextFormField(
                          controller: name,                          
                          decoration: InputDecoration(
                            hintText: 'Shop Name',
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                          iconSize: 15,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          style: TextStyle(fontSize: 18, fontFamily: 'Nunito-SemiBold', color: AppColors.lightTheme),
                          items: locations.map((String location) {
                            return DropdownMenuItem(
                              value: location,
                              child: Text(
                                location,
                                style: TextStyle(
                                  color: AppColors.lightTheme,
                                  fontSize: 18
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: 'Location',
                            border: InputBorder.none                            
                          ),
                          validator: (input) {
                            return input != null || input != '' 
                                ? null
                                : 'Please select a location';
                          },
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },                   
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                        ),                        
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : "Please provide a valid email id";
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextFormField(
                          controller: password,
                          obscureText: hidePassword,
                          validator: (value) {
                            return value.length > 6
                              ? null
                              : "Please provide a password which has more than 6 characters";
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(
                                hidePassword ? Icons.visibility : Icons.visibility_off, color: AppColors.darkTheme,),
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                        
                            Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Nunito-ExtraBold',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightTheme
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if(formKey.currentState.validate()) {
                                  Map<String, dynamic> shopUser = {
                                    'name': name.text,
                                    'email': email.text,
                                    'isShop': true,
                                    'password': password.text
                                  };
                                  Navigator.pushReplacement(context, PageTransition(
                                    child: ShopDetails(shopUserInfo: shopUser, location: location,),
                                    type: PageTransitionType.rightToLeftWithFade
                                  ));
                                }
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.lightTheme,
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                child: Center(
                                  child: Icon(Icons.arrow_forward_outlined, color: Colors.white,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito-SemiBold'
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(context, PageTransition(
                                child: SignIn(),
                                type: PageTransitionType.leftToRightWithFade
                              )),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.lightTheme,
                                  fontFamily: 'Nunito-SemiBold'
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}