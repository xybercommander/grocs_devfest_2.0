// @dart=2.9
import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/chats/chatroom_list.dart';
import 'package:grocs/views/shop_preview.dart';
import 'package:page_transition/page_transition.dart';

class CustomerMainPage extends StatefulWidget {
  const CustomerMainPage({ Key key }) : super(key: key);

  @override
  _CustomerMainPageState createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {

  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: databaseMethods.getShopsList(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/account_image.png'),
                      backgroundColor: Colors.transparent,
                      radius: 28,
                    ),
                    title: Text(snapshot.data.docs[index]['name']),
                    subtitle: Text(snapshot.data.docs[index]['description']),
                    tileColor: Colors.amber, 
                    onTap: () {
                      Navigator.push(context, PageTransition(
                        child: ShopPreview(snapshot.data.docs[index]),
                        type: PageTransitionType.rightToLeftWithFade
                      ));
                    },   
                  ),
                ),
              );
            },
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => ChatRoomList(),
        backgroundColor: AppColors.lightTheme,
        child: Icon(Icons.chat_rounded),
      ),
    );
  }
}