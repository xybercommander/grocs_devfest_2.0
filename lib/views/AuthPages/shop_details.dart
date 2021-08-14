import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/navigator_page.dart';
import 'package:page_transition/page_transition.dart';

class ShopDetails extends StatefulWidget {
  final Map shopUserInfo; 
  const ShopDetails({ Key? key, required this.shopUserInfo }) : super(key: key);

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {

  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();
  bool delivery = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();  

  shopSignUp() {
    authMethods.signUpWithEmailAndPassword(widget.shopUserInfo['email'], widget.shopUserInfo['password'])
        .then((value) async {
          UserConstants.name = widget.shopUserInfo['name'];
          UserConstants.email = widget.shopUserInfo['email'];
          UserConstants.isShop = true;

          Map<String, dynamic> shopUserInfo = {
            'name': widget.shopUserInfo['name'],
            'isShop': true,            
            'email': widget.shopUserInfo['email']
          };          
          await databaseMethods.uploadUserInfo(shopUserInfo);

          Map<String, dynamic> shopData = {
            'contact': phone.text,
            'delivery': true,
            'description': description.text,
            'name': widget.shopUserInfo['name']
          };
          databaseMethods.uploadShopInfo(shopData);
          
          Navigator.pushReplacement(context, PageTransition(
            child: NavigatorPage(),
            type: PageTransitionType.rightToLeftWithFade
          ));
        });
  }

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
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                      child: Text(
                        'Add more Details',
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
                      child: TextField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
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
                      child: TextField(
                        controller: description,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(horizontal: 32),                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deliveries'),
                          Checkbox(
                            value: delivery,
                            fillColor: MaterialStateProperty.all<Color>(AppColors.lightTheme),
                            onChanged: (value) {
                              setState(() {
                                delivery = value!;
                              });                              
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [                        
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Nunito-ExtraBold',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightTheme
                            ),
                          ),
                          InkWell(
                            onTap: () => shopSignUp(),
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
                              color: Colors.black
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
                                color: AppColors.lightTheme
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}