// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/navigator_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class ShopDetails extends StatefulWidget {
  final Map shopUserInfo; 
  final String location;
  const ShopDetails({ Key key, @required this.shopUserInfo, @required this.location }) : super(key: key);

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {

  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();
  bool delivery = false;

  File _image;
  String imgUrl = '';

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();  

  shopSignUp() async {
    if(_image != null) {
      await uploadPic();
    }

    authMethods.signUpWithEmailAndPassword(widget.shopUserInfo['email'], widget.shopUserInfo['password'])
        .then((value) async {
          UserConstants.name = widget.shopUserInfo['name'];
          UserConstants.email = widget.shopUserInfo['email'];
          UserConstants.isShop = true;
          if(imgUrl != '') UserConstants.imgUrl = imgUrl;

          Map<String, dynamic> shopUserInfo = {
            'name': widget.shopUserInfo['name'],
            'isShop': true,            
            'email': widget.shopUserInfo['email'],
            'imgUrl': imgUrl
          };          
          await databaseMethods.uploadUserInfo(shopUserInfo);

          Map<String, dynamic> shopData = {
            'contact': phone.text,
            'delivery': true,
            'description': description.text,
            'name': widget.shopUserInfo['name'],
            'imgUrl': imgUrl,
            'location': widget.location
          };
          databaseMethods.uploadShopInfo(shopData);

          SharedPref.saveNameSharedPreference(widget.shopUserInfo['name']);
          SharedPref.saveEmailSharedPreference(widget.shopUserInfo['email']);
          SharedPref.saveIsShopSharedPreference(true);
          SharedPref.saveLoggedInSharedPreference(true);
          if(imgUrl != '') SharedPref.saveImgUrlSharedPreference(imgUrl);
          
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
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
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
                          Text('Deliveries', style: TextStyle(fontFamily: 'Nunito-SemiBold', color: AppColors.lightTheme)),
                          Checkbox(
                            value: delivery,
                            fillColor: MaterialStateProperty.all<Color>(AppColors.lightTheme),
                            onChanged: (value) {
                              setState(() {
                                delivery = value;
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
              )
            ],
          ),
        ),
      ),
    );
  }
}