import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/utils/colors.dart';
import 'package:grocs/views/chats/chat_screen.dart';
import 'package:page_transition/page_transition.dart';

// Chat room list tile widget
class ChatRoomListTile extends StatefulWidget {
  final String chatRoomId;
  final String lastMessage;
  bool isCompany;
  ChatRoomListTile(this.chatRoomId, this.lastMessage, this.isCompany);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {

  // DatabaseMethods databaseMethods = DatabaseMethods();
  // String name = '', profilePic = '', lastMessage = '';
  String name = '';
  var names = [];  
  
  getThisUserName() async {    
    names = widget.chatRoomId.split('_');
    int i = names.indexOf(UserConstants.name);
    i == 0 ? name = names[1] : name = names[0];
    setState(() {});
  }

  @override
  void initState() {
    getThisUserName();    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, PageTransition(
        child: ChatScreen(name),
        type: PageTransitionType.bottomToTop
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          child: Container(
            height: 60,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),      
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(   
                  backgroundImage: AssetImage('assets/images/account_image.png'),           
                  backgroundColor: Colors.white,
                  radius: 20,
                ),
                SizedBox(width: 20,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [            
                      Text(name, style: TextStyle(
                        color: AppColors.lightTheme,
                        fontSize: 25
                      ),),
                      Text(
                        widget.lastMessage.length > 30 ? widget.lastMessage.substring(0, 30) + '...' : widget.lastMessage, 
                        overflow: TextOverflow.ellipsis, 
                        style: TextStyle(
                        fontSize: 13,
                        color: AppColors.lightTheme.withOpacity(0.8)
                      ),)
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}