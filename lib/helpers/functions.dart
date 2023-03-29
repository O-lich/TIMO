import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/fetch_helper.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';


  Future<void> createNewList({
    required TextEditingController listController,
  }) async {
    String listID = UniqueKey().toString();
    final newList = ListModel(
      list: listController.text,
      listID: listID,
    );
    await addNewList(
      newList: newList,
    );
  }

  Future<void> addNewList({
    required ListModel newList,
  }) async {
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .withConverter(
      toFirestore: (ListModel task, options) => task.toFirestore(),
      fromFirestore: ListModel.fromFirestore,
    )
        .doc(newList.listID);
    await docRef.set(newList);
  }

  Future<void> deleteTask({
    required TaskModel oldTask,
  }) async {
    db
        .collection("users")
        .doc(oldTask.userID)
        .collection('lists')
        .doc(oldTask.listID)
        .collection('tasks')
        .doc(oldTask.taskID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

Future<void> deleteList({
  required ListModel oldList,
}) async {
  db
      .collection("users")
      .doc('testUser')
      .collection('lists')
      .doc(oldList.listID)
      .delete()
      .then(
        (doc) => print("Document deleted"),
    onError: (e) => print("Error updating document $e"),
  );
}

Future<void> updateListColor({
  required ListModel oldList,
  required int listColorIndex
}) async {
  final docRef = db
      .collection("users")
      .doc('testUser')
      .collection('lists')
      .doc(oldList.listID);

  final updates = <String, int>{
    "listColorIndex": listColorIndex,
  };
  docRef.update(updates);
}

  void createNewTask({
    required TextEditingController taskController,
  }) {
    if (taskController.text.isNotEmpty) {
      addNewTask(
        text: taskController.text,
        taskID: UniqueKey().toString(),
        listID: currentLists[selectedListIndex].listID,
        colorIndex: taskCurrentColorIndex,
        dateTimeReminder: currentDateTimeReminder,
        isReminderActive: currentIsReminderActive,
      );

      taskCurrentColorIndex = -1;
      listCurrentColorIndex = 0;
      currentDateTimeReminder = '2000-01-01 00:00:00';
      currentIsReminderActive = false;
    }
  }

  Future<void> moveToFromMainScreenTask({
    required TaskModel updatedTask,
  }) async {
    db
        .collection("users")
        .doc(updatedTask.userID)
        .collection('lists')
        .doc(updatedTask.listID)
        .collection('tasks')
        .doc(updatedTask.taskID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
    addNewTaskUpdate(
      newTask: TaskModel(
        task: updatedTask.task,
        colorIndex: updatedTask.colorIndex,
        listID: currentLists[moveToListIndex].listID,
        dateTimeReminder: updatedTask.dateTimeReminder,
        userID: updatedTask.userID,
        isReminderActive: updatedTask.isReminderActive,
        taskID: updatedTask.taskID,
      ),
    );
    moveToListIndex = -1;
  }

  Future<void> addNewTaskUpdate({
    //ToDo two different
    required final newTask,
  }) async {
    final docRef = db
        .collection("users")
        .doc(newTask.userID)
        .collection('lists')
        .doc(newTask.listID)
        .collection('tasks')
        .withConverter(
      toFirestore: (TaskModel task, options) => task.toFirestore(),
      fromFirestore: TaskModel.fromFirestore,
    )
        .doc(newTask.taskID);
    await docRef.set(newTask);
    currentList = ListModel(list: 'ToDo', listID: 'ToDo');
  }

  Future<void> addNewTask({
    //ToDo
    required String text,
    required String taskID,
    required int colorIndex,
    String? listID,
    required String dateTimeReminder,
    bool? isReminderActive,
  }) async {
    final newTask = TaskModel(
      task: text,
      userID: currentUser.userID,
      taskID: taskID,
      listID: listID!.isNotEmpty ? listID : 'ToDo',
      colorIndex: colorIndex,
      dateTimeReminder: dateTimeReminder,
      isReminderActive: isReminderActive ?? false,
    );
    final docRef = db
        .collection("users")
        .doc(newTask.userID)
        .collection('lists')
        .doc(newTask.listID)
        .collection('tasks')
        .withConverter(
      toFirestore: (TaskModel task, options) => task.toFirestore(),
      fromFirestore: TaskModel.fromFirestore,
    )
        .doc(newTask.taskID);
    await docRef.set(newTask);
  }

  Future<List<TaskModel>> getTasks({
    required ListModel listModel,
  }) async {
    currentTasks.clear();
    await getLists();
    final tasksRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .doc(listModel.listID)
        .collection("tasks")
        .withConverter(
      fromFirestore: TaskModel.fromFirestore,
      toFirestore: (TaskModel task, _) => task.toFirestore(),
    )
        .get()
        .then(
          (querySnapshot) =>
          querySnapshot.docs.map((doc) => doc.data()).toList(),
      onError: (e) => print("Error completing: $e"),
    );

    return await tasksRef;
  }

  Future<List<ListModel>> getLists() async {
    final ref = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .withConverter(
      fromFirestore: ListModel.fromFirestore,
      toFirestore: (ListModel list, _) => list.toFirestore(),
    )
        .get()
        .then(
          (querySnapshot) =>
          querySnapshot.docs.map((doc) => doc.data()).toList(),
      onError: (e) => log("Error completing: $e"),
    );
    currentLists = await ref;
    if (currentLists.isEmpty) {
      addToDoList();
      currentLists = [
        ListModel(
          listID: 'ToDo',
          list: 'ToDo',
        ),
      ];
    }
    return currentLists;
  }

  Future<void> addToDoList() async {
    final list = ListModel(
      listID: 'ToDo',
      list: 'ToDo',
    );
    final docRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection('lists')
        .withConverter(
      toFirestore: (ListModel list, options) => list.toFirestore(),
      fromFirestore: ListModel.fromFirestore,
    )
        .doc('ToDo');
    await docRef.set(list);
  }

  //ToDo move to main
  Future<void> getUsers() async {
    final ref = db.collection("users").doc(currentUser.userID).withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, _) => user.toFirestore(),
    );
    final docSnap = await ref.get();
    if (docSnap.data() != null) {
      currentUser = docSnap.data()!;
    } else {
      addNewUser();
    }
  }

  //ToDo move to main
  Future<void> addNewUser() async {
    final docRef = db
        .collection("users")
        .withConverter(
      toFirestore: (UserModel user, options) => user.toFirestore(),
      fromFirestore: UserModel.fromFirestore,
    )
        .doc(currentUser.userID);
    await docRef.set(currentUser);
  }

  int changeLocale({required BuildContext context, required int index}) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    final locale = Locales.allLocales[index];
    provider.setLocale(locale);
    updateUser(locale: index);

    currentUser.locale = index;
    return index;
  }

  Future<void> updateUser({
    required int locale,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('locale', locale);
    final docRef = db.collection("users").doc(currentUser.userID);
    final updates = <String, dynamic>{
      'locale': locale,
    };
    await docRef.update(updates);
  }

  Future<QuoteModel> updateQuote() async {
    final dataDecoded = await FetchHelper().getData();
    return QuoteModel.fromJson(dataDecoded);
  }

Future<void> updateListText({
  required ListModel oldList,
  required TextEditingController controller
}) async {
  final docRef = db
      .collection("users")
      .doc('testUser')
      .collection('lists')
      .doc(oldList.listID);

  final updates = <String, String>{
    "list": controller.text,
  };
  docRef.update(updates);
}