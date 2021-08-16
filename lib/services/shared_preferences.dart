  
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String loggedInSharedPreferenceKey = 'LOGINKEY';
  static String isShopSharedPreferenceKey = ' ISSHOPKEY';
  static String emailSharedPreferenceKey = 'EMAILKEY';
  static String nameSharedPreferenceKey = 'NAMEKEY';
  static String imgUrlSharedPreferenceKey = 'IMGURLKEY';
  static String darkModeSharedPreferenceKey = 'DARKMODEKEY';

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

  static Future<void> saveImgUrlSharedPreference(String imgUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(imgUrlSharedPreferenceKey, imgUrl);
  }

  static Future<void> saveDarkModeSharedPreference(bool darkMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(darkModeSharedPreferenceKey, darkMode);
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

  static Future<String?> getImgUrlInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(imgUrlSharedPreferenceKey);
  }

  static Future<bool?> getDarkModeInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(darkModeSharedPreferenceKey);
  }
}