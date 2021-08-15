// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:grocs/constants/encryption_constants.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/widgets/chat_widgets.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatRoomsStream;
  bool isCompany;  
  final encrypter = Encrypter(AES(EncryptionConstants.encryptionKey));    

  getChatRooms() async {
    chatRoomsStream = await databaseMethods.getChatRooms();
    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {        
        return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.only(top: 24),       
          itemCount: snapshot.data.docs.length + 1,
          itemBuilder: (context, index) {            
            if(index == 0) {
              return Container(
                padding: EdgeInsets.only(top: 40, left: 16, bottom: 16),
                child: Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 50,
                    color: AppColors.lightTheme,
                    fontFamily: 'Nunito-Bold'
                  ),
                ),
              );
            }

            DocumentSnapshot ds = snapshot.data.docs[index - 1];
            String message = encrypter.decrypt64(ds['lastMessage'], iv: EncryptionConstants.iv);            
            return ChatRoomListTile(ds.id, message, isCompany);
          },
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [             
              Text('Seems empty', style: TextStyle(color: AppColors.lightTheme),)
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: !UserConstants.isShop ? AppBar(        
      //   title: Text('Chatroom List Page'),
      // ) : null,

      body: chatRoomsList()
    );
  }
}