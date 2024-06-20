import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Base.dart';
import 'package:todo/Models/TaskModel.dart';

class Task_TabViewModel extends BaseViewModel<BaseConnector> {
  CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.tojson();
      },
    );
  }

  Stream<QuerySnapshot<TaskModel>> ?getTasks(DateTime dateTime) {
    try {
      // connector!.showLoading();
      return
        getTasksCollection()
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("date",
              isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
          .snapshots();
      connector!.hideLoading();

    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showMessage("Error");
    }

  }
}
