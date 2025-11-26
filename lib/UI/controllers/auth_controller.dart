import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class AuthController {
  static final String _tokenKey = 'token';
  static final String _userKey = 'user';

  static String? accessToken; //Access token string
  static UserModel? user; //User model instance

  /// Method to save token and User Info if  login and Reg Seccessful
  static Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Get SharedPreferences instance

    if (token.isNotEmpty) {
      // Save user info as JSON string
      await sharedPreferences.setString(_tokenKey, token); // Save token
      await sharedPreferences.setString(
        _userKey,
        jsonEncode(userModel.toJson()),
      );
      accessToken = token; // Save token in memory
      user = userModel; // Save user model in memory
      debugPrint('User Data Saved');
    } else {
      debugPrint('Token is empty. User Data not saved.');
    }
  }

  /// Method to Update  UserInfo Info if  login and Reg Seccessful
  static Future<void> updateUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Get SharedPreferences instance
    // Save user info as JSON string
    await sharedPreferences.setString(_userKey, jsonEncode(userModel.toJson()));
    user = userModel; // Save user model in memory
    debugPrint('User Data Saved');
  }

  /// Method to load token and User Info when app starts get from SharedPreferences
  static Future<void> loadUserData() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Get SharedPreferences instance

    String? token = sharedPreferences.getString(
      _tokenKey,
    ); // Retrieve token ,Read Savede token
    if (token != null) {
      accessToken = token; //Saved token in Memory if token is not null
      user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString(_userKey)!),
      ); //Retrieve and decode user info from JSON string ,json->dart object
    }
  }

  /// Method to Cheak If User Already Logged In
  static Future<bool> isuserAlreadyLoggedIn() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Get SharedPreferences instance

    String? token = sharedPreferences.getString(_tokenKey); //Read Token Key
    return token != null; //Return true if token is not null otherwise false
  }

  /// Method to Clear User Data on Logout
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Get SharedPreferences instance
    sharedPreferences.clear(); // Clear all data in SharedPreferences

    //await sharedPreferences.remove(_tokenKey); // Remove token
    //await sharedPreferences.remove(_userKey); // Remove user info
  }
}
