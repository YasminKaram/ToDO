import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Models/TaskModel.dart';
import 'package:todo/Models/UserModel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
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

  //نوعها Future<void> لان ال set(taskModel) نوعها كدا

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var documentRef = collection.doc();
    taskModel.id = documentRef.id;
    return documentRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
        .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)

        .snapshots();
  }

  static void deleteTask(String id) {
    getTasksCollection().doc(id).delete();
  }

  static void updateTask(TaskModel task) {
    getTasksCollection().doc(task.id).update({
      "isDone": task.isDone,
    });
  }

  static void EditTask(TaskModel task) {
    getTasksCollection().doc(task.id).update({
      "title": task.title,
      "date": task.date,
      "description": task.description
    });
  }

  static Future<void> createUser(String email, String password,String name,int age,Function onSuccess,Function onError)async {

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user?.uid !=null){
        UserModel userModel=UserModel(name: name, id: credential.user!.uid, email: email, age: age);
        addUserToFirestore(userModel).then((value) {
          onSuccess();
        });

      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');

      }
    } catch (e) {
      print(e);

    }

  }


  static Future<void>login(String email,String password, Function onSuccess,Function onError)async{

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //email verify
      credential.user!.sendEmailVerification();
      if(credential.user?.uid != null){

//check verify before login
        if(credential.user!.emailVerified){

          onSuccess();
        }
        else{
          onError("Please verify your email");

        }



      }
    } on FirebaseAuthException catch (e) {
      onError("Wrong email or password");
      // if (e.code == 'user-not-found') {
      //   onError(e.message);
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   onError(e.message);
      //   print('Wrong password provided for that user.');
      // }
    }
  }



  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static  addUserToFirestore(UserModel userModel){

var collection=getUsersCollection();
var doccref=collection.doc(userModel.id);
return doccref.set(userModel);

  }

  static Future<UserModel?> readUserFromFirestore(String id) async{
    DocumentSnapshot<UserModel> doc=
    await getUsersCollection().doc(id).get();
     return doc.data();
  }

}
