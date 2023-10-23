import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/Models/TaskModel.dart';
import 'package:todo/Screens/Tasks/EditTask.dart';
import 'package:todo/Shared/Firebase/Firebase_function.dart';
import 'package:todo/Shared/style/Colors.dart';
import 'package:todo/Shared/style/MyThemedata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(task.id);
              },
              spacing: 0,
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14)),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.routeName,
                    arguments: TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      id: task.id,
                        title: task.title,
                        description: task.description,
                        date: task.date),);
              },
              spacing: 0,
              label: "Edit",
              icon: Icons.delete,
              backgroundColor: Colors.blue,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 3,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task.title}",
                        style: Theme.of(context).textTheme.bodySmall),
                    Text("${task.description}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 18)),
                  ],
                ),
                Spacer(),
                task.isDone
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green),
                        child: Text("Done!"))
                    : InkWell(
                        onTap: () {
                          task.isDone = true;
                          FirebaseFunctions.updateTask(task);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
