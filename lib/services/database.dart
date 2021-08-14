import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  // Upload user info map to firestore (company or customer)
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  uploadShopInfo(shopInfoMap) {
    FirebaseFirestore.instance.collection('shops').add(shopInfoMap);
  }

}