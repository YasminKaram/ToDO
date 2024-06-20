import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Base.dart';
import 'package:todo/Models/TaskModel.dart';
import 'package:todo/Screens/Tasks/TaskItem.dart';
import 'package:todo/Screens/Tasks/TaskTab/TaskTabConnector.dart';
import 'package:todo/Screens/Tasks/TaskTab/Task_TabViewModel.dart';
import 'package:todo/Shared/Firebase/Firebase_function.dart';
import 'package:todo/Shared/style/Colors.dart';

class TasksTab extends StatefulWidget {
  static const String routeName = "tasks";

 const TasksTab({super.key});


  @override
  State<TasksTab> createState() => _TasksTabState();
}

DateTime selectedDate=DateTime.now();

class _TasksTabState extends BaseView<Task_TabViewModel,TasksTab> implements Task_TabConnector{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Column(
        children: [
          CalendarTimeline(

            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date){
              setState(() {
                selectedDate=date;

              });
            },

            leftMargin: 20,
            monthColor: primaryColor,
            dayColor: primaryColor.withOpacity(.90),
            activeDayColor: Colors.white,

            activeBackgroundDayColor: primaryColor,
            dotsColor: Colors.white,
            //دي عشان اوقف ايام محدده مقدرش احددها زي ما عملت يوم 15
            selectableDayPredicate: (date) => date.day != 15,
            locale: 'en',
          ),
          StreamBuilder(
            stream: viewModel.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              List<TaskModel>tasks = snapshot.data?.docs.map((e) => e.data())
                  .toList() ?? [] ;
              if(tasks.isEmpty){
                return Center(child: Text("No Tasks"));
              }

              return Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return TaskItem(task: tasks[index],);
                },
                  itemCount: tasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Task_TabViewModel initMyViewModel() {
   return Task_TabViewModel();
  }
}
