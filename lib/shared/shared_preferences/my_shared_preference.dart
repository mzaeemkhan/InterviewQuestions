import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static final SharedPreferencesServices _customSharedPreferences = SharedPreferencesServices._internal();

  factory SharedPreferencesServices() {
    return _customSharedPreferences;
  }

  SharedPreferencesServices._internal();

  Future storeDataList({data, required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, jsonEncode(data));
  }

  Future<String?> getDataList({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key)) {
      return (preferences.getString(key));
    }
    return null;
  }

  Future storeString({required String input, required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, input);
  }

  Future<String?> getString({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key)) {
      return (preferences.getString(key));
    }
    return null;
  }

  Future savedBoolValue({required bool value, required String key}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }
  Future<bool> getBoolValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool boolValue = false;

    try{
      if (preferences.containsKey(key)) {
        boolValue = preferences.getBool(key) ?? false;
      }
    }catch(exception){
      boolValue = false;
    }
    return boolValue ;
  }
}
