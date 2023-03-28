import 'package:shared_preferences/shared_preferences.dart';

class saveState {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userFullnameKey = "USERFULLNAMEKEY";
  static String userNicknameKey = "USERNAMEKEY";
  static String userPhoneKey = "USERNAMEKEY";

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<bool> saveFullname(String userFullname) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userFullnameKey, userFullname);
  }

  static Future<String?> getFullname() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userFullnameKey);
  }

  static Future<bool> savePhone(String userPhone) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userPhoneKey, userPhone);
  }

  static Future<String?> getPhone() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userPhoneKey);
  }

  static Future<bool> saveNickname(String userNickname) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNicknameKey, userNickname);
  }

  static Future<String?> getNickname() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNicknameKey);
  }
}
