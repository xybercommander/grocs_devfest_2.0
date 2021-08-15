// @dart=2.9
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/profile_type.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/navigator_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({ Key key }) : super(key: key);

  @override
  _CustomerSignUpState createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hidePassword = true;
  File _image;
  String imgUrl = '';

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  customerSignUp() async {
    if(_image != null) {
      await uploadPic();
    }

    authMethods.signUpWithEmailAndPassword(email.text, password.text)
        .then((value) {
          UserConstants.name = name.text;
          UserConstants.email = email.text;
          UserConstants.isShop = false;

          Map<String, dynamic> customerInfo = {
            'name': name.text,
            'email': email.text,
            'isShop': false,
            'imgUrl': imgUrl
          };
          databaseMethods.uploadUserInfo(customerInfo);

          SharedPref.saveNameSharedPreference(name.text);
          SharedPref.saveEmailSharedPreference(email.text);
          SharedPref.saveIsShopSharedPreference(false);
          SharedPref.saveLoggedInSharedPreference(true);

          Navigator.pushReplacement(context, PageTransition(
            child: NavigatorPage(),
            type: PageTransitionType.rightToLeftWithFade
          ));
        });
  }

  final picker = ImagePicker();
  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: 'No Image Picked!',
            textColor: Colors.white,
            backgroundColor: Color.fromRGBO(253, 170, 142, 1));
      }
    });
  }

  Future uploadPic() async {
    final file = _image;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child(file.path);
    await reference.putFile(file);
    imgUrl = await reference.getDownloadURL();
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
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
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
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: _image == null 
                                  ? AssetImage('assets/images/account_image.png')
                                  : FileImage(_image),
                              backgroundColor: Colors.transparent,
                              radius: 35,
                            ),
                            TextButton(
                              onPressed: () {
                                getImage();
                              },
                              child: Text(
                                '+Add Image',
                                style: TextStyle(
                                  color: AppColors.lightTheme,
                                  fontFamily: 'Nunito-Bold'
                                ),
                              ),
                            )
                          ],
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
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Nunito-ExtraBold',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightTheme
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                customerSignUp();
                                // if(formKey.currentState.validate()) {
                                //   customerSignUp();
                                // }
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}