// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:grocs/constants/encryption_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/services/shared_preferences.dart';
import 'package:grocs/utils/colors.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithName;  
  ChatScreen(this.chatWithName);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String chatRoomId, messageId = '';
  String myName, profilePic, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream messageStream;

  final encrypter = Encrypter(AES(EncryptionConstants.encryptionKey));
  

  // Initial functions to be executed
  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getMyInfo() async {    
    myName = await SharedPref.getNameInSharedPreference();    
    myEmail = await SharedPref.getEmailInSharedPreference();
    chatRoomId = getChatRoomId(widget.chatWithName, myName);
  }

  doThisOnLaunch() async {
    await getMyInfo();
    getAndSetMessages();
  }// Initial functions ended



  // Chat room functions
  Widget chatBubble(String text, bool sendByMe) {
    return Align(
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(              
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),        
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(sendByMe ? 0 : 20),
            bottomLeft: Radius.circular(!sendByMe ? 0 : 20),
          ),
          gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  sendByMe ? AppColors.lightTheme : Color.fromRGBO(194, 200, 197, 1),
                  sendByMe ? AppColors.lightTheme : Color.fromRGBO(221, 221, 218, 1),
                ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: sendByMe ? Colors.white : Colors.blueGrey[900]),),
          ),
      ),
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          physics: BouncingScrollPhysics(),
          reverse: true,
          padding: EdgeInsets.only(bottom: 80),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index]; 

            String message = encrypter.decrypt64(ds['message'], iv: EncryptionConstants.iv);           

            return chatBubble(message, myName == ds['sendBy']);
          },
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              Text('Seems empty')
            ],
          ),
        );
      },
    );
  }


  getAndSetMessages() async {
    messageStream = await databaseMethods.getChatRoomMessages(chatRoomId);
    setState(() {}); // setting the state after fetching the messages
  }


  // synchronizing the messages
  addMessage(bool sendClicked) {
    if(messageTextEditingController.text != '') {
            
      final encrypted = encrypter.encrypt(messageTextEditingController.text, iv: EncryptionConstants.iv);
      String message = encrypted.base64;
      var lastMessageTimeStamp = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        'message' : message,
        'sendBy' : myName,
        'ts' : lastMessageTimeStamp //  the timestamp of the msg
      };

      if(messageId == '') {
        messageId = randomAlphaNumeric(12);
      }

      databaseMethods.addMessage(chatRoomId, messageId, messageInfoMap)
        .then((value) {
          Map<String, dynamic> lastMessageInfoMap = {
            'lastMessage': message,
            'lastMessageSentTs' : lastMessageTimeStamp,
            'lastMessageSentBy' : myName
          };   

          databaseMethods.updateLastMessageSent(chatRoomId, lastMessageInfoMap);      

          if(sendClicked) {
            // remove the text
            messageTextEditingController.text = '';    
            messageId = '';
          }
        });
    }
  }  


  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatWithName),
        backgroundColor: AppColors.lightTheme,        
      ),

      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppColors.lightTheme,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        // onChanged: (value) {
                        //   addMessage(false);
                        // },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type a message..',
                          hintStyle: TextStyle(color: Colors.white54)
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(Icons.send, color: Colors.white,)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}