  
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String loggedInSharedPreferenceKey = 'LOGINKEY';
  static String isShopSharedPreferenceKey = ' ISSHOPKEY';
  static String emailSharedPreferenceKey = 'EMAILKEY';
  static String nameSharedPreferenceKey = 'NAMEKEY';

  //-------- SET FUNCTION --------//

  static Future<void> saveLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(loggedInSharedPreferenceKey, isUserLoggedIn);
  }

  static Future<void> saveIsShopSharedPreference(bool isShop) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(isShopSharedPreferenceKey, isShop);
  }

  static Future<void> saveEmailSharedPreference(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(emailSharedPreferenceKey, email);
  }

  static Future<void> saveNameSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(nameSharedPreferenceKey, name);
  }

  //-------- GET FUNCTION --------//

  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loggedInSharedPreferenceKey);
  }

  static Future<bool?> getIsShopInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isShopSharedPreferenceKey);
  }

  static Future<String?> getEmailInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(emailSharedPreferenceKey);
  }

  static Future<String?> getNameInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameSharedPreferenceKey);
  }
}