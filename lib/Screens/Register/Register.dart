import 'package:flutter/material.dart';
import 'package:todo/Screens/Register/Login_tab/Login.dart';
import 'package:todo/Screens/Register/SignUp.dart';
import 'package:todo/Shared/style/Colors.dart';

class RegisterScreen extends StatelessWidget {
static const String routeName="Register";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              toolbarHeight: 40,
              backgroundColor: primaryColor.withOpacity(0.7),
              bottom: TabBar(

                tabs: [
                  Tab(child: Text("Login",style:Theme.of(context).textTheme.bodyMedium,),),
                  Tab(child: Text("Sign Up",style:Theme.of(context).textTheme.bodyMedium),),
                ],
              ),
            ),
            body: TabBarView(children: [
              LoginScreen(),
              SignupScreen()
            ]),
          ),
        ));
  }
}
