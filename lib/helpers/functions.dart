import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/fetch_helper.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';
import 'package:image_picker/image_picker.dart';

Future<List<ListModel>> createNewList({
  required TextEditingController listController,
}) async {
  String listID = DateTime.now().millisecondsSinceEpoch.toString();
  final newList = ListModel(
    list: listController.text,
    listID: listID,
  );
  await addNewList(
    newList: newList,
  );
  log('created $listController.text');

  final ref = await db
      .collection("users")
      .doc(currentUser.userID)
      .collection("lists")
      .withConverter(
        fromFirestore: ListModel.fromFirestore,
        toFirestore: (ListModel list, _) => list.toFirestore(),
      )
      .get()
      .then(
        (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList(),
        onError: (e) => log("Error completing: $e"),
      );

  return ref;
}

Future<void> addNewList({
  required ListModel newList,
}) async {
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
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
        (doc) => log("Document deleted"),
        onError: (e) => log("Error updating document $e"),
      );
}

Future<void> deleteList({
  required ListModel oldList,
}) async {
  db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .doc(oldList.listID)
      .delete()
      .then(
        (doc) => log("Document deleted"),
        onError: (e) => log("Error updating document $e"),
      );

  FirebaseStorage.instance
      .ref()
      .child(currentUser.userID)
      .child('${oldList.listID}.jpg')
      .delete();
}

Future<void> updateListColor({
  required ListModel oldList,
  required int listColorIndex,
}) async {
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .doc(oldList.listID);

  final updates = <String, int>{
    "listColorIndex": listColorIndex,
  };
  docRef.update(updates);
}

void createNewTask(
    {required TextEditingController taskController,
    required ListModel currentList,
    required String dateTimeReminder,
    required bool isReminderActive,
    required int taskColorIndex}) {
  if (taskController.text.isNotEmpty) {
    addNewTask(
      text: taskController.text,
      taskID: DateTime.now().millisecondsSinceEpoch.toString(),
      listID: currentList.listID,
      colorIndex: taskColorIndex,
      dateTimeReminder: dateTimeReminder,
      isReminderActive: isReminderActive,
    );
  }
  moveToListIndex = -1;
}

Future<void> moveToFromMainScreenTask({
  required TaskModel updatedTask,
  required ListModel moveToListModel,
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
        (doc) => log("Document deleted"),
        onError: (e) => log("Error updating document $e"),
      );
  addNewTaskUpdate(
    newTask: TaskModel(
      task: updatedTask.task,
      colorIndex: updatedTask.colorIndex,
      listID: moveToListModel.listID,
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
}

Future<void> addNewTask({
  //ToDo
  required String text,
  required String taskID,
  required int colorIndex,
  required String listID,
  required String dateTimeReminder,
  bool? isReminderActive,
}) async {
  final newTask = TaskModel(
    task: text,
    userID: currentUser.userID,
    taskID: taskID,
    listID: listID,
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
        (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList(),
        onError: (e) => log("Error completing: $e"),
      );

  return await tasksRef;
}

Future<List<ListModel>> getLists() async {
  final ref = await db
      .collection("users")
      .doc(currentUser.userID)
      .collection("lists")
      .withConverter(
        fromFirestore: ListModel.fromFirestore,
        toFirestore: (ListModel list, _) => list.toFirestore(),
      )
      .get()
      .then(
        (querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList(),
        onError: (e) => log("Error completing: $e"),
      );

  if (ref.isEmpty) {
    return [await addToDoList()];
  } else {
    return ref;
  }
}

Future<ListModel> addToDoList() async {
  final list = ListModel(
      listID: DateTime.now().millisecondsSinceEpoch.toString(),
      list: 'ToDo',
      listImageUrl: "");
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .withConverter(
        toFirestore: (ListModel list, options) => list.toFirestore(),
        fromFirestore: ListModel.fromFirestore,
      )
      .doc(list.listID);
  await docRef.set(list);

  final ref = await db
      .collection("users")
      .doc(currentUser.userID)
      .collection("lists")
      .doc(list.listID)
      .withConverter(
        fromFirestore: ListModel.fromFirestore,
        toFirestore: (ListModel list, _) => list.toFirestore(),
      )
      .get();
  return ref.data()!;
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
  updateUserLocale(locale: index);

  currentUser.locale = index;
  return index;
}

Future<void> updateUserLocale({
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

Future<void> updateUserPanelTapped() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isClosePanelTapped', true);
  final docRef = db.collection("users").doc(currentUser.userID);
  final updates = <String, dynamic>{
    'isClosePanelTapped': true,
  };
  await docRef.update(updates);
  await getUsers();
}

Future<QuoteModel> updateQuote() async {
  final dataDecoded = await FetchHelper().getData();
  return QuoteModel.fromJson(dataDecoded);
}

Future<void> updateListText({
  required ListModel oldList,
  required String text,
}) async {
  if (text.isNotEmpty) {
    final docRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection('lists')
        .doc(oldList.listID);

    final updates = <String, String>{
      "list": text,
    };
    docRef.update(updates);
  }
}

TaskModel newTaskReminderSet({
  required DateTime? chosenDateTime,
  required TaskModel taskModel,
  required BuildContext context,
}) {
  TaskModel newTaskModel = taskModel;
  if (chosenDateTime == null || chosenDateTime.isBefore(DateTime.now())) {
    wrongReminder(context: context);
  } else if (chosenDateTime.isAfter(DateTime.now())) {
    newTaskModel.isReminderActive = true;
    newTaskModel.dateTimeReminder = chosenDateTime.toString();
    Navigator.pop(context);
  }
  return newTaskModel;
}

TaskModel newTaskReminderDelete({
  required TaskModel taskModel,
  required BuildContext context,
}) {
  TaskModel newTaskModel = taskModel;
  newTaskModel.isReminderActive = false;
  newTaskModel.dateTimeReminder = '2000-01-01 00:00:00';
  Navigator.pop(context);
  return newTaskModel;
}

Future<TaskModel> singleTaskReminderSet({
  required DateTime? chosenDateTime,
  required TaskModel taskModel,
  required BuildContext context,
}) async {
  TaskModel updatedTaskModel = taskModel;
  if (chosenDateTime == null || chosenDateTime.isBefore(DateTime.now())) {
    wrongReminder(context: context);
  } else if (chosenDateTime.isAfter(DateTime.now())) {
    Navigator.pop(context);
    await updateTaskReminder(
        updatedTask: taskModel,
        dateTimeReminder: chosenDateTime.toString(),
        isReminderActive: true);
    final ref = await db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .doc(taskModel.listID)
        .collection("tasks")
        .doc(taskModel.taskID)
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, _) => task.toFirestore(),
        )
        .get();
    updatedTaskModel = ref.data()!;
  }
  return updatedTaskModel;
}

Future<TaskModel> singleTaskReminderDelete({
  required TaskModel taskModel,
  required BuildContext context,
}) async {
  TaskModel updatedTaskModel = taskModel;
  await updateTaskReminder(
      updatedTask: taskModel,
      dateTimeReminder: '2000-01-01 00:00:00',
      isReminderActive: false);
  final ref = await db
      .collection("users")
      .doc(currentUser.userID)
      .collection("lists")
      .doc(taskModel.listID)
      .collection("tasks")
      .doc(taskModel.taskID)
      .withConverter(
        fromFirestore: TaskModel.fromFirestore,
        toFirestore: (TaskModel task, _) => task.toFirestore(),
      )
      .get();
  updatedTaskModel = ref.data()!;

  return updatedTaskModel;
}

void wrongReminder({required BuildContext context}) {
  Duration duration = const Duration(seconds: 3);
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return TweenAnimationBuilder<Duration>(
          duration: duration,
          tween: Tween(begin: duration, end: Duration.zero),
          onEnd: () {
            Navigator.of(context).pop(true);
          },
          builder: (BuildContext context, Duration value, Widget? child) {
            return CupertinoAlertDialog(
              title: Text(S.of(context).wrongReminder),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                    child: Text(S.of(context).cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
    },
  );
}

Future<void> updateTaskReminder({
  required TaskModel updatedTask,
  required dateTimeReminder,
  required isReminderActive,
}) async {
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .doc(updatedTask.listID)
      .collection('tasks')
      .doc(updatedTask.taskID);

  final updates = <String, dynamic>{
    "dateTimeReminder": dateTimeReminder,
    "isReminderActive": isReminderActive,
  };
  docRef.update(updates);
}

Future<void> updateTask({
  required TaskModel updatedTask,
  required TextEditingController textController,
  required ListModel? moveToListModel,
}) async {
  if (moveToListModel == null) {
    final docRef = db
        .collection("users")
        .doc(updatedTask.userID)
        .collection('lists')
        .doc(updatedTask.listID)
        .collection('tasks')
        .doc(updatedTask.taskID);

    final updates = <String, dynamic>{
      'task': textController.text,
      'colorIndex': (taskCurrentColorIndex == -1) ? -1 : taskCurrentColorIndex,
    };
    docRef.update(updates);
  } else {
    db
        .collection("users")
        .doc(updatedTask.userID)
        .collection('lists')
        .doc(updatedTask.listID)
        .collection('tasks')
        .doc(updatedTask.taskID)
        .delete()
        .then(
          (doc) => log("Document deleted"),
          onError: (e) => log("Error updating document $e"),
        );
    addNewTaskUpdate(
      newTask: TaskModel(
        task: textController.text,
        colorIndex: (taskCurrentColorIndex == -1)
            ? updatedTask.colorIndex
            : taskCurrentColorIndex,
        listID: moveToListModel.listID,
        dateTimeReminder: updatedTask.dateTimeReminder,
        userID: updatedTask.userID,
        isReminderActive: updatedTask.isReminderActive,
        taskID: updatedTask.taskID,
      ),
    );
  }
  moveToListIndex = -1;
  taskCurrentColorIndex = -1;
}

Future<File?> chooseFileToListImage() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 10,
  );
  if (pickedFile == null) {
    return null;
  } else {
    return File(pickedFile.path);
  }
}

// Future<XFile?> takePhotoToListImage() async {
//   final cameras = await availableCameras();
//   final camera = cameras.first;
//   final controller = CameraController(camera, ResolutionPreset.medium);
//   await controller.initialize();
//   final picture = await controller.takePicture();
//   return XFile(picture.path);
// }

Future<bool> showImagePickerDialog({
  required BuildContext context,
  required File imageFile,
}) async {
  Completer<bool> completer = Completer<bool>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(S.of(context).updateThumbnail),
        content: Image.file(imageFile),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(false);
            },
            child: Text(
              S.of(context).cancel,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(true);
            },
            child: Text(S.of(context).okButton),
          ),
        ],
      );
    },
  );
  return completer.future;
}

// Future<bool> showCameraImagePickerDialog({
//   required BuildContext context,
//   required XFile imageFile,
// }) async {
//   Completer<bool> completer = Completer<bool>();
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: Text(S.of(context).updateThumbnail),
//         content: Image.file(File(imageFile.path)),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               completer.complete(false);
//             },
//             child: Text(
//               S.of(context).cancel,
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               completer.complete(true);
//             },
//             child: Text(S.of(context).okButton),
//           ),
//         ],
//       );
//     },
//   );
//   return completer.future;
// }

Future<void> updateListImage({
  required ListModel listModel,
  required File imageFile,
}) async {
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .doc(listModel.listID);
  final Reference storageRef = FirebaseStorage.instance
      .ref()
      .child(currentUser.userID)
      .child('${listModel.listID}.jpg');
  final UploadTask uploadTask = storageRef.putFile(imageFile);
  final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
  final String imageUrl = await downloadUrl.ref.getDownloadURL();
  final updates = <String, String>{
    "listImageUrl": imageUrl,
  };
  docRef.update(updates);
}

// Future<void> uploadListImageFromCamera(
//     {required ListModel listModel, required XFile takenPhoto}) async {
//   final docRef = db
//       .collection("users")
//       .doc(currentUser.userID)
//       .collection('lists')
//       .doc(listModel.listID);
//   final Reference storageRef = FirebaseStorage.instance
//       .ref()
//       .child(currentUser.userID)
//       .child('${listModel.listID}.jpg');
//   final UploadTask uploadTask = storageRef.putFile(File(takenPhoto.path));
//   final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
//   final String imageUrl = await downloadUrl.ref.getDownloadURL();
//   final updates = <String, String>{
//     "listImageUrl": imageUrl,
//   };
//   docRef.update(updates);
// }

Future<int> updateOrDeleteImageDialog(
    {required BuildContext context, required ListModel listModel}) async {
  Completer<int> completer = Completer<int>();
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return listModel.listImageUrl.isNotEmpty
            ? CupertinoActionSheet(
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: Text(
                      S.of(context).deleteThumbnail,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete(1);
                    },
                  ),
                  // CupertinoActionSheetAction(
                  //   child: const Text(
                  //     'Take photo',
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     completer.complete(3);
                  //   },
                  // ),
                  CupertinoActionSheetAction(
                    child: Text(
                      S.of(context).choosePhoto,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete(2);
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  child: Text(
                    S.of(context).cancel,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(0);
                  },
                ),
              )
            : CupertinoActionSheet(
                actions: <Widget>[
                  // CupertinoActionSheetAction(
                  //   child: Text(
                  //     'Take photo',
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     completer.complete(3);
                  //   },
                  // ),
                  CupertinoActionSheetAction(
                    child: Text(
                      S.of(context).choosePhoto,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete(2);
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  child: Text(S.of(context).cancel),
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(0);
                  },
                ),
              );
      });
  return completer.future;
}

Future<void> deleteListImage({
  required ListModel oldList,
}) async {
  final docRef = db
      .collection("users")
      .doc(currentUser.userID)
      .collection('lists')
      .doc(oldList.listID);
  final updates = <String, String>{
    "listImageUrl": '',
  };
  docRef.update(updates);

  FirebaseStorage.instance
      .ref()
      .child(currentUser.userID)
      .child('${oldList.listID}.jpg')
      .delete();
}

Future showNotification({
  required FlutterLocalNotificationsPlugin localNotifications,
  required int notificationID,
  required String title,
  required String subtitle,
}) async {
  const androidDetails = AndroidNotificationDetails(
    "ID",
    "Название уведомления",
    importance: Importance.high,
  );
  const iosDetails = DarwinNotificationDetails();
  const generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
  await localNotifications.show(
      notificationID, title, subtitle, generalNotificationDetails);
}

Future cancelNotification({
  required FlutterLocalNotificationsPlugin localNotifications,
  required int notificationID,
}) async {
  await localNotifications.cancel(notificationID);
}
