import 'package:flutter/material.dart';
import 'package:todo/Screens/Register/Login.dart';
import 'package:todo/Screens/Register/SignUp.dart';

class RegisterScreen extends StatelessWidget {
static const String routeName="Register";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Login",style:Theme.of(context).textTheme.bodyMedium,)),
                Tab(child: Text("Sign Up",style:Theme.of(context).textTheme.bodyMedium),),
              ],
            ),
          ),
          body: TabBarView(children: [
            LoginScreen(),
            SignupScreen()
          ]),
        ));
  }
}
