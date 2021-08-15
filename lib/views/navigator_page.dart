import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/auth.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/AuthPages/sign_in_page.dart';
import 'package:grocs/views/chats/chatroom_list.dart';
import 'package:grocs/views/customer_main_page.dart';
import 'package:grocs/views/settings_page.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({ Key? key }) : super(key: key);

  @override
  NavigatorPageState createState() => NavigatorPageState();
}

class NavigatorPageState extends State<NavigatorPage> {

  PageController pageController = PageController(initialPage: 0);
  AuthMethods authMethods = AuthMethods();
  List<Widget> pages = [];
  int _selectedIndex = 0;

  setPages() {
    if(UserConstants.isShop) {
      setState(() {
        pages.add(ChatRoomList());
        pages.add(SettingsPage());
      });
    } else {
      setState(() {
        pages.add(CustomerMainPage());
        pages.add(SettingsPage());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    setPages();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      pages = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Navigator Page', style: TextStyle(color: Colors.white),),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout, color: Colors.white),
      //       onPressed: () => signOut()
      //     )
      //   ],
      // ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(        
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            pageController.animateToPage(_selectedIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(UserConstants.isShop ? Icons.chat : Icons.home,
                color: _selectedIndex == 0
                    ? AppColors.lightTheme
                    : Colors.grey[400]),
            title: Text(
                UserConstants.isShop ? 'Chats' : 'Shops',
                style: TextStyle(
                  color: _selectedIndex == 0
                    ? AppColors.lightTheme
                    : Colors.grey[400]
                ),
              ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,
                color: _selectedIndex == 1
                    ? AppColors.lightTheme
                    : Colors.grey[400]),
            title: Text(
                'Settings',
                style: TextStyle(
                  color: _selectedIndex == 1
                    ? AppColors.lightTheme
                    : Colors.grey[400]
                ),
              ),
          ),          
        ],
      ),
    );
  }
}