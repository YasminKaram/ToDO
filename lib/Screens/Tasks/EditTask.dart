import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/TaskModel.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Screens/Tasks/tasks_tab.dart';
import 'package:todo/Shared/Firebase/Firebase_function.dart';
import 'package:todo/Shared/style/Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/layout/homeLayout.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "Edit";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  bool choose = false;
  var dateData;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = args.title;
    descriptionController.text = args.description;
    dateData=DateTime.fromMillisecondsSinceEpoch(
        args.date);

    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff5D9CEC)),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: pro.mode == ThemeMode.light
                    ? Color(0xffDFECDB)
                    : darkPrimary),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Color(0xff5D9CEC)),
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("To Do List", style: TextStyle(color: Colors.white)),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 75, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                    color:pro.mode==ThemeMode.light? Colors.white: darkPrimary,
                    borderRadius: BorderRadius.circular(25)),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Edit Task")),
                      ),
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter task title";
                                      }
                                      return null;
                                    },
                                    controller: titleController,style:Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(),)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter task description";
                                      }
                                      return null;
                                    },
                                    controller: descriptionController,style:Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder())),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(AppLocalizations.of(context)!.selectdate,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: pro.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white)),
                              InkWell(
                                onTap: () {
                                  selectDate(context);
                                },
                                child: Text(
                                    choose == false
                                        ? dateData
                                            .toString()
                                            .substring(0, 10)
                                        : selectedDate
                                            .toString()
                                            .substring(0, 10),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue)),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        TaskModel taskModel = TaskModel(
                                          userId: FirebaseAuth.instance.currentUser!.uid,
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            id: args.id,
                                            date: DateUtils.dateOnly(choose ==
                                                        false
                                                    ? dateData
                                                    : selectedDate)
                                                .millisecondsSinceEpoch);
                                        FirebaseFunctions.EditTask(taskModel);
                                      }
                                      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                                      setState(() {});
                                    },
                                    child: Text("Save changes",
                                        style: TextStyle(fontSize: 20)),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 150,
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: dateData,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    onSurface: Colors.blue)),
            child: child!);
      },
    );
    if (chosenDate == null) {
      return;
    } else {
      selectedDate = chosenDate;
      choose = true;
      setState(() {});
    }
  }
}
