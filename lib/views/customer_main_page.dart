// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
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

          return snapshot.data.docs.length > 0 ? ListView.builder(
            itemCount: snapshot.data.docs.length + 1,
            itemBuilder: (context, index) {
              if(index == 0) {
                return Container(
                  padding: EdgeInsets.only(top: 40, left: 16, bottom: 16),
                  child: Text(
                    'Shops',
                    style: TextStyle(
                      fontSize: 50,
                      color: AppColors.lightTheme,
                      fontFamily: 'Nunito-Bold'
                    ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(snapshot.data.docs[index - 1]['imgUrl']),
                      backgroundColor: Colors.transparent,
                      radius: 28,
                    ),
                    title: Text(snapshot.data.docs[index - 1]['name']),
                    subtitle: Text(
                      snapshot.data.docs[index - 1]['description'], 
                      style: TextStyle(
                        color: AppColors.lightTheme.withOpacity(0.8)
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(context, PageTransition(
                        child: ShopPreview(snapshot.data.docs[index - 1]),
                        type: PageTransitionType.rightToLeftWithFade
                      ));
                    },   
                  ),
                ),
              );
            },
          ) : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/not-found.png', height: 100, width: 100,),
                SizedBox(height: 16,),
                Text(
                  'No shops found :(', 
                  style: TextStyle(
                    color: AppColors.lightTheme, 
                    fontFamily: 'Nunito-Bold',
                    fontSize: 30
                  ),
                )
              ],
            )
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, PageTransition(
          child: ChatRoomList(),
          type: PageTransitionType.rightToLeftWithFade
        )),
        backgroundColor: AppColors.lightTheme,
        child: Icon(Icons.chat_rounded),
      ),
    );
  }
}