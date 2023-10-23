import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/UserModel.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Screens/Register/Register.dart';
import 'package:todo/Screens/Settings/settings_tab.dart';
import 'package:todo/Screens/Tasks/addTaskBottomSheet.dart';
import 'package:todo/Screens/Tasks/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/Shared/style/Colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "layout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)!.titleApp} ${pro.userModel?.name}",
        ),
        centerTitle: true,
        actions: [
          //reset password
          IconButton(onPressed:(){
            FirebaseAuth.instance.sendPasswordResetEmail(email:pro.userModel!.email);
          },
              icon: Icon(Icons.send,)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterScreen.routeName, (route) => false);
              },
              icon: Icon(
                Icons.logout,
              )),


        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: pro.mode == ThemeMode.light ? Colors.white : darkPrimary,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            onTap: (value) {
              index = value;
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: Icon(
                    Icons.list,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: Icon(Icons.settings),
                  label: ""),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSheet();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[index],
    );
  }

  showSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
