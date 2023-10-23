import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/Models/UserModel.dart';
import 'package:todo/Shared/Firebase/Firebase_function.dart';
import 'package:todo/prefs_Helper.dart';

class MyProvider extends ChangeNotifier {
  String Language = "en";
  ThemeMode mode = ThemeMode.light;

   User   ? firebaseUser;
   UserModel   ?userModel ;

  //constructor
  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void changeLanguage(String langCode) {
    Language = langCode;
    PrefsHelper.setLanguage(langCode);
    notifyListeners();
  }

  void changeTheming(ThemeMode thememode) {
    mode = thememode;
    if (thememode == ThemeMode.light) {
      PrefsHelper.setTheming("light");
    } else {
      PrefsHelper.setTheming("dark");
    }
    notifyListeners();
  }

  void init() async {
    String? newLang = PrefsHelper.getLanguage();
    changeLanguage(newLang ?? "en");
    String? newMode = PrefsHelper.getTheming();
    if (newMode == "light") {
      changeTheming(ThemeMode.light);
    } else {
      changeTheming(ThemeMode.dark);
    }
  }

  initUser() async {
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel  =await FirebaseFunctions.readUserFromFirestore
      (firebaseUser!.uid);
    notifyListeners();
  }
}
