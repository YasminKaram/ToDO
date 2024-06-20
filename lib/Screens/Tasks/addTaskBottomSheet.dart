import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/TaskModel.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Shared/Firebase/Firebase_function.dart';
import 'package:todo/Shared/style/Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

    var selectedDate = DateTime.now();
  var formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formkey ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.addnewTask,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: pro.mode == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "please enter task title";
                  }
                  return null;
                },
                  controller: titleController,
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.taskTitle),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "please enter task description";
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.taskDescription),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)))),
            ),
            Text(AppLocalizations.of(context)!.selectdate,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color:pro.mode==ThemeMode.light?Colors.black:Colors.white)),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Text(selectedDate.toString().substring(0, 10),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: primaryColor)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {


                if(formkey.currentState!.validate()){
                  TaskModel taskModel = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,

                      title: titleController.text,
                      description: descriptionController.text,
                      date:
                      DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                  FirebaseFunctions.addTask(taskModel).then((value) {
                    Navigator.pop(context);
                    // هنشيل .then  في حاله انه local
                  });
                }


              },
              child: Text(AppLocalizations.of(context)!.addTask),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            )
          ],
        ),
      ),
    );
  }

    selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
      setState(() {});
    }
  }
}
