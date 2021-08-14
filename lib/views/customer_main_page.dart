// @dart=2.9
import 'package:flutter/material.dart';
import 'package:grocs/constants/user_constants.dart';
import 'package:grocs/services/database.dart';
import 'package:grocs/utils/colors.dart';

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
              return ListTile(
                title: Text(snapshot.data.docs[index]['name']),
                subtitle: Text(snapshot.data.docs[index]['contact']),
                                
              );
            },
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.lightTheme,
        child: Icon(Icons.chat_rounded),
      ),
    );
  }
}