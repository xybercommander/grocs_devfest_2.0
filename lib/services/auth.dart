// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocs/models/user_profile_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserProfile _userFromFirebaseUser(User user) {
    return user != null ? UserProfile(userId: user.uid) : null;
  }

  //--------- SIGN IN ---------//
  Future<UserProfile> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
    }
  }

  //--------- SIGN UP ---------//
  Future<UserProfile> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
    }
  }

  //--------- RESET PASSWORD ---------//
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }  

  //--------- SIGN OUT ---------//
  Future signOut() async {
    try {
      return _auth.signOut();
    }catch(e){
      print(e.toString());
    } 
  } 
}