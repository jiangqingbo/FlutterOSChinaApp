import 'package:flutter_oschina_demo/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// author: bobo
/// create time: 2019/4/11 4:19 PM
/// email: jqbo84@163.com
///

class DataUtils {
  static const String SP_ACCESS_TOKEN = 'access_token';
  static const String SP_REFRESH_TOKEN = 'refresh_token';
  static const String SP_UID = 'uid';
  static const String SP_TOKEN_TYPE = 'token_type';
  static const String SP_EXPIRES_IN = 'expires_in';
  static const String SP_IS_LOGIN = 'is_login';

  static const String SP_USER_GENDER = 'gender';
  static const String SP_USER_ID = 'id';
  static const String SP_USER_NAME = 'name';
  static const String SP_USER_LOCATION = 'location';
  static const String SP_USER_AVATAR = 'avatar';
  static const String SP_USER_EMAIL = 'email';
  static const String SP_USER_URL = 'url';
  static const String SP_USER_JSON_STRING = 'user_json_string';

//  {"access_token":"aa105aaf-ca4f-4458-822d-1ae6a1fa33f9","refresh_token":"daae8b80-3ca6-4514-a8ae-acb3a82c951c","uid":2006874,"token_type":"bearer","expires_in":510070}
  static Future<void> saveLoginInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp
        ..setString(SP_ACCESS_TOKEN, map[SP_ACCESS_TOKEN])
        ..setString(SP_REFRESH_TOKEN, map[SP_REFRESH_TOKEN])
        ..setInt(SP_UID, map[SP_UID])
        ..setString(SP_TOKEN_TYPE, map[SP_TOKEN_TYPE])
        ..setInt(SP_EXPIRES_IN, map[SP_EXPIRES_IN])
        ..setBool(SP_IS_LOGIN, true);
    }
  }

  //{"gender":"male","name":"江清波","location":"上海 浦东","id":133912,"avatar":"https://static.oschina.net/uploads/user/66/133912_50.jpg?t=1453255864000","email":"jqbo84@163.com","url":"https://my.oschina.net/409734331"}
  static Future<void> saveUserInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp
        ..setString(SP_USER_GENDER, map[SP_USER_GENDER])
        ..setString(SP_USER_ID, map[SP_USER_ID])
        ..setString(SP_USER_NAME, map[SP_USER_NAME])
        ..setString(SP_USER_LOCATION, map[SP_USER_LOCATION])
        ..setString(SP_USER_AVATAR, map[SP_USER_AVATAR])
        ..setString(SP_USER_EMAIL, map[SP_USER_EMAIL])
        ..setString(SP_USER_URL, map[SP_USER_URL]);
    }
  }

  static Future<void> saveUserWithJsonString(String json) async {
    if (json != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp..setString(SP_USER_JSON_STRING, json);
    }
  }

  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_ACCESS_TOKEN, '')
      ..setString(SP_REFRESH_TOKEN, '')
      ..setInt(SP_UID, -1)
      ..setString(SP_TOKEN_TYPE, '')
      ..setInt(SP_EXPIRES_IN, -1)
      ..setBool(SP_IS_LOGIN, false);
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_USER_JSON_STRING, '')
      ..setInt(SP_USER_ID, -1)
      ..setString(SP_USER_GENDER, '')
      ..setString(SP_USER_NAME, '')
      ..setString(SP_USER_LOCATION, '')
      ..setString(SP_USER_AVATAR, '')
      ..setString(SP_USER_EMAIL, '')
      ..setString(SP_USER_URL, '');
  }

  //是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  //获取token
  static Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_ACCESS_TOKEN);
  }

  //获取用户ID
  static Future<String> getUserID() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_UID);
  }

  //获取用户名
  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_USER_NAME);
  }

  //获取用户头像
  static Future<String> getUserAvatar() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_USER_AVATAR);
  }

  //获取用户信息
  static Future<String> getUserJsonString() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_USER_JSON_STRING);
  }

  //获取用户信息
  static Future<User> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }
    User user = new User();
    user.gender = sp.getString(SP_USER_GENDER);
    user.name = sp.getString(SP_USER_NAME);
    user.location = sp.getString(SP_USER_LOCATION);
    user.id = sp.getInt(SP_USER_ID);
    user.avatar = sp.getString(SP_USER_AVATAR);
    user.email = sp.getString(SP_USER_EMAIL);
    user.url = sp.getString(SP_USER_URL);
    return user;
  }

}
