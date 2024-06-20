import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Base.dart';
import 'package:todo/Screens/Register/Login_tab/LoginConnecter.dart';

class LoginViewModel extends BaseViewModel<LoginConnector>{

  //late LoginConnector loginConnector;
   Future<void>login(String email,String password)async{

    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //email verify
      credential.user!.sendEmailVerification();
      if(credential.user?.uid != null){

//check verify before login
        if(credential.user!.emailVerified){
          connector!.hideLoading();
          connector!.goToHome();

        }
        else{
          connector!.hideLoading();
          connector!.showMessage("Please verify your email");


        }


      }
    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showMessage("${e.message}");

    }
  }
}