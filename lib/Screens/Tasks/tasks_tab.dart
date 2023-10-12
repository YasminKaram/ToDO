import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screens/Tasks/TaskItem.dart';
import 'package:todo/Shared/style/Colors.dart';

class TasksTab extends StatelessWidget {
  static const  String routeName="tasks";
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CalendarTimeline(
        initialDate: DateTime.now(),
        firstDate:DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)),
        onDateSelected: (date) => print(date),
        leftMargin: 20,
        monthColor: primaryColor,
        dayColor: primaryColor.withOpacity(.70),
        activeDayColor: Colors.white,
        activeBackgroundDayColor:primaryColor,
        dotsColor: Colors.white,
        //دي عشان اوقف ايام محدده مقدرش احددها زي ما عملت يوم 15
        selectableDayPredicate: (date) => date.day != 15,
        locale: 'en',
      ),
     Expanded(
       child: ListView.builder(itemBuilder: (context, index) {
         return TaskItem();
       },
       itemCount: 8,),
     )
    ],);
  }
}
