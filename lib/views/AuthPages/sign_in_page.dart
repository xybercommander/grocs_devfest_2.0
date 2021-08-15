// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/auth_page.dart';
import 'package:grocs/views/AuthPages/profile_type.dart';
import 'package:page_transition/page_transition.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthMethods authMethods = AuthMethods();

  bool hidePassword = true;

  signIn() async {
    Stream<QuerySnapshot> userStream = await databaseMethods.getUserInfoByEmail(email.text);
    authMethods.signInWithEmailAndPassword(email.text, password.text)
        .then((value) {
          Navigator.pushReplacement(context, PageTransition(
            child: AuthPage(userStream: userStream,),
            type: PageTransitionType.rightToLeftWithFade
          ));
        });
  }

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
                height: MediaQuery.of(context).size.height / 1.4,
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
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 40,
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
                          controller: email,
                          validator: (value) {
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : "Please provide a valid email id";
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Nunito-SemiBold'),
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
                            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Nunito-SemiBold'),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(
                                hidePassword ? Icons.visibility : Icons.visibility_off, 
                                color: AppColors.darkTheme,
                              ),
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
                              'Sign In',
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
                                  signIn();
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
                              'New user or company?   ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito-SemiBold'
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(context, PageTransition(
                                child: ProfileType(),
                                type: PageTransitionType.rightToLeftWithFade
                              )),
                              child: Text(
                                'Sign Up',
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