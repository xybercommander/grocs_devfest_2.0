import 'package:flutter/material.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/profile_type.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/customer_navigator.dart';
import 'package:page_transition/page_transition.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({ Key? key }) : super(key: key);

  @override
  _CustomerSignUpState createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hidePassword = true;

  AuthMethods authMethods = AuthMethods();

  signUp() {
    authMethods.signUpWithEmailAndPassword(email.text, password.text)
        .then((value) {
          Navigator.pushReplacement(context, PageTransition(
            child: CustomerNavigator(),
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
                        'Get Started',
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
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Name',
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
                        controller: email,
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
                      child: TextField(
                        controller: password,
                        obscureText: hidePassword,
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
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Nunito-ExtraBold',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightTheme
                            ),
                          ),
                          InkWell(
                            onTap: () => signUp(),
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