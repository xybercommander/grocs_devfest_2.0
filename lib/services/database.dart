import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  // Upload user info map to firestore (shop or customer)
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  uploadShopInfo(shopInfoMap) {
    FirebaseFirestore.instance.collection('shops').add(shopInfoMap);
  }

  //-------- GET THE USER DATA --------//
  Future<Stream<QuerySnapshot>> getUserInfoByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .snapshots();
  }

}