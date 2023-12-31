import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{
  static late SharedPreferences prefs;


  static setLanguage(String language) async{
    await prefs.setString("lang",language );

  }
  static String? getLanguage(){
    return prefs.getString("lang");

  }
  static  setTheming(String mode)async{
    await prefs.setString("mode", mode);
  }
  static String? getTheming(){
    return prefs.getString("mode") ?? "light";

  }

}