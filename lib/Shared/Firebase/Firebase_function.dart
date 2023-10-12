import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/Models/TaskModel.dart';

class FirebaseFunctions {


   static CollectionReference <TaskModel> getTasksCollection() {
     return
    FirebaseFirestore.instance.collection("Tasks").withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.tojson();
      },
    );
  }

 static void addTask(TaskModel taskModel) {
     var collection=getTasksCollection();
     var documentRef=collection.doc();
     taskModel.id=documentRef.id;
     documentRef.set(taskModel);


  }
}
