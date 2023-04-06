import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  int colorIndex;
  bool isReminderActive;
  String task;
  String listID;
  String userID;
  String taskID;
  String dateTimeReminder;

  TaskModel({
    this.dateTimeReminder = '2000-01-01 00:00:00',
    this.userID = 'testUser',
    this.taskID = '',
    this.colorIndex = -1,
    this.isReminderActive = false,
    required this.task,
    this.listID = "ToDo",
  });

  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskModel(
      colorIndex: data?['colorIndex'],
      dateTimeReminder: data?['dateTimeReminder'],
      isReminderActive: data?['isReminderActive'],
      task: data?['task'],
      listID: data?['listID'],
      userID: data?['userID'],
      taskID: data?['taskID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "dateTimeReminder" : dateTimeReminder,
      "colorIndex": colorIndex,
      "isReminderActive": isReminderActive,
      "task": task,
      "listID": listID,
      "userID": userID,
      "taskID": taskID,
    };
  }
}

// class ReminderTaskModel extends SingleTaskModel {
//   DateTime dateTimeReminder;
//
//   ReminderTaskModel({
//     required super.task,
//     required this.dateTimeReminder,
//     required super.userID,
//   });
// }
