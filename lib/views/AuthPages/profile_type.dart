import 'package:flutter/material.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/customer_sign_up.dart';
import 'package:page_transition/page_transition.dart';

class ProfileType extends StatelessWidget {
  const ProfileType({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your\nProfile Type',
              style: TextStyle(
                fontFamily: 'Nunito-Bold',
                color: AppColors.lightTheme,
                fontSize: 50
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(context, PageTransition(
                child: CustomerSignUp(),
                type: PageTransitionType.rightToLeftWithFade
              )),
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 4, color: AppColors.lightTheme),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle_rounded, color: AppColors.darkTheme, size: 80,),
                    Text(
                      'Customer',
                      style: TextStyle(
                        color: AppColors.darkTheme,
                        fontSize: 24
                      ),
                    ),
                    Text(
                      'Select this if you\'re registering as a Customer',
                      style: TextStyle(
                        color: AppColors.darkTheme,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              width: MediaQuery.of(context).size.width - 32,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: AppColors.darkTheme,                
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag, color: AppColors.lightTheme, size: 80,),
                  Text(
                    'Grocery Shop',
                    style: TextStyle(
                      color: AppColors.lightTheme,
                      fontSize: 24
                    ),
                  ),
                  Text(
                    'Select this if you\'re a Grocery Shop',
                    style: TextStyle(
                      color: AppColors.lightTheme,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}