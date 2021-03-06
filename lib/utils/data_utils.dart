import 'package:flutter_app/bean/my_infor_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const UID = 'uid';
  static const TOKEN_TYPE = 'token_type';
  static const EXPIRES_IN = 'expires_in';

  static const USER_NAME = 'user_name';
  static const USER_AVATAR = 'user_avatar';
  static const USER_ID = 'user_id';

  static saveTokenInfor(Map<String, dynamic> map) async {
//       //{access_token: 95a1f9a1-4c4e-4e6a-aeed-f609c6a295a8, refresh_token: 7dccbfed-60ce-4834-9663-c963b0ae9c11, uid: 4114419, token_type: bearer, expires_in: 604736}
    SharedPreferences sp = await SharedPreferences.getInstance();
    DateTime dateTime = DateTime.now();
    int currentSecond = dateTime.second;
    sp
      ..setString(ACCESS_TOKEN, map[ACCESS_TOKEN])
      ..setString(REFRESH_TOKEN, map[REFRESH_TOKEN])
      ..setInt(UID, map[UID])
      ..setString(TOKEN_TYPE, map[TOKEN_TYPE])
      ..setInt(EXPIRES_IN, map[EXPIRES_IN] + currentSecond);
  }

  static Future<bool> clearLoginInfor() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
      sp
      ..setString(ACCESS_TOKEN, "")
      ..setString(REFRESH_TOKEN, "")
      ..setInt(UID, -1)
      ..setString(TOKEN_TYPE, "")
      ..setInt(EXPIRES_IN, -1)
      ..setString(USER_NAME, '')
      ..setString(USER_AVATAR, '')
      ..setInt(USER_ID, -1);

    return true;
  }

  static Future<String> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(ACCESS_TOKEN);
  }

  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    DateTime dateTime = DateTime.now();
    int currentSecond = dateTime.second;
    var token = sp.getString(ACCESS_TOKEN);
    int time = sp.getInt(EXPIRES_IN);
    String userName = sp.getString(USER_NAME);
    return token != null && time > currentSecond && userName != null;
  }

  static void saveLoginInfor(LoginInfor loginInfor) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp
      ..setString(USER_NAME, loginInfor.name)
      ..setString(USER_AVATAR, loginInfor.avatar)
      ..setInt(USER_ID, loginInfor.id);
  }

  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(USER_NAME);
  }

  static Future<String> getUserAvatar() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(USER_AVATAR);
  }

  static Future<String> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(USER_ID);
  }
}
