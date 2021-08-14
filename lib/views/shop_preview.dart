// THIS PAGE IS FOR THE COMPANY PREVIEW PAGE

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/chats/chat_screen.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class ShopPreview extends StatelessWidget {
  QueryDocumentSnapshot queryDocumentSnapshot;
  ShopPreview(this.queryDocumentSnapshot);
  
  DatabaseMethods databaseMethods = DatabaseMethods();

  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.lightTheme
                      // image: DecorationImage(
                      //   image: _setCover(),
                      //   fit: BoxFit.cover
                      // )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back, color: Colors.white,), 
                      onPressed: () { 
                        Navigator.pop(context);
                       },
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: 20,),
                    Text('${queryDocumentSnapshot['name']}', style: TextStyle(fontSize: 40, color: AppColors.lightTheme), textAlign: TextAlign.center,),
                    SizedBox(height: 10,),
                    Text('${queryDocumentSnapshot['contact']}', style: TextStyle(fontSize: 25, color: AppColors.lightTheme), textAlign: TextAlign.center,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                      height: 0.5,                   
                      color: Colors.blueGrey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        '${queryDocumentSnapshot['description']}',
                        style: TextStyle(fontSize: 18, color: AppColors.lightTheme),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: RaisedButton.icon(
                            onPressed: () {
                              var chatRoomId = getChatRoomId(UserConstants.name, queryDocumentSnapshot['name']);
                              Map<String, dynamic> chatRoomInfoMap = {
                                'users' : [UserConstants.name, queryDocumentSnapshot['name']]
                              };
                              databaseMethods.createChatRoom(chatRoomId, chatRoomInfoMap);

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ChatScreen(queryDocumentSnapshot['name']),
                              ));
                            },
                            shape: StadiumBorder(),
                            elevation: 3,
                            icon: Icon(Icons.chat, color: Colors.white, size: 30,),
                            label: Text('Contact', style: TextStyle(color: Colors.white, fontSize: 20),),
                            color: AppColors.lightTheme,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 3,
            top: 120,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/account_image.png'),
              backgroundColor: Colors.grey[100],
              radius: 60,
            ),
          ),
        ],
      ),
    );
  }
}