//import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/add_new_list_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/ui/widgets/reminder_panel_widget.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  List<FocusNode> focusNodeList = [];
  List<TextEditingController> controllerList = [];

  AppBloc() : super(const AppStateSplashScreen()) {
    on<AppEventGetUser>(
      (event, emit) async {
        emit(
          const AppStateSplashScreen(),
        );
        try {
          quote = await updateQuote();
          await getUsers();
          final listsList = await getLists();
          final tasksList = await getTasks(
            listModel: listsList[selectedListIndex],
          );
          emit(
            LoadedAppState(
                tasksList: tasksList,
                quoteModel: quote,
                listModel: listsList[selectedListIndex],
                listsList: listsList),
          );
        } on Exception {
          emit(const ErrorAppState());
        }
      },
    );
    on<AppEventGoToLists>((event, emit) async {
      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
            listsList: listsList,
            focusNodeList: focusNodeList,
            controllerList: controllerList),
      );
    });
    on<AppEventGoToNewTask>((event, emit) async {
      emit(
        AddNewTaskAppState(
          listsList: event.listsList,
          isReminderActive: false,
          dateTimeReminder: '2000-01-01 00:00:00',
        ),
      );
    });
    on<AppEventGoToMainView>((event, emit) async {
      emit(
        LoadingAppState(
          listModel: event.listModel,
        ),
      );
      try {
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: listsList[selectedListIndex],
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventAddNewTask>((event, emit) async {
      emit(LoadingAppState(listModel: event.listModel));
      try {
        createNewTask(
          taskController: event.taskController,
          currentList: event.listModel,
          dateTimeReminder: event.dateTimeReminder,
          isReminderActive: event.isReminderActive,
          taskColorIndex: event.taskColorIndex,
        );
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });

    // on<AppEventGoToSettingsFromPremiumView>((event, emit) async {
    //   emit(
    //    const AppTestAppState()
    //   );
    //   await Future.delayed(Duration(seconds: 1));
    //   // await Navigator.push(
    //   //   event.context,
    //   //   PageRouteBuilder(
    //   //     pageBuilder: (context, animation, secondaryAnimation) =>
    //   //     const SettingsView(),
    //   //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //   //       const begin = Offset(0.0, 1.0);
    //   //       const end = Offset.zero;
    //   //       const curve = Curves.ease;
    //   //       final tween = Tween(begin: begin, end: end);
    //   //       final curvedAnimation = CurvedAnimation(
    //   //         parent: animation,
    //   //         curve: curve,
    //   //       );
    //   //       return SlideTransition(
    //   //         position: tween.animate(curvedAnimation),
    //   //         child: child,
    //   //       );
    //   //     },
    //   //   ),
    //   // );
    //   emit(
    //     const SettingsAppState(),
    //   );
    // });

    on<AppEventGoToSettings>((event, emit) async {
      emit(
        const SettingsAppState(),
      );
    });

    on<AppEventGoToPremium>((event, emit) async {
      emit(
        const PremiumAppState(),
      );
    });
    on<AppEventGoToSingleTask>((event, emit) async {
      final taskModel = event.taskModel;
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
          taskModel: taskModel,
          listsList: listsList,
          isClosePanelTapped: currentUser.isClosePanelTapped,
          listModel: listsList[selectedListIndex],
        ),
      );
    });
    on<AppEventAddNewListFromTaskScreen>((event, emit) async {
      await createNewList(listController: event.listController);
      final listsList = await getLists();
      final taskModel = event.taskModel;
      emit(
        SingleTaskAppState(
          taskModel: taskModel,
          listsList: listsList,
          isClosePanelTapped: currentUser.isClosePanelTapped,
          listModel: listsList[selectedListIndex],
        ),
      );
    });
    on<AppEventGoToLanguage>((event, emit) async {
      emit(
        LanguageAppState(locale: currentUser.locale),
      );
    });
    on<AppEventChangeLocale>((event, emit) async {
      final int locale =
          changeLocale(context: event.context, index: event.index);
      emit(
        LanguageAppState(locale: locale),
      );
    });
    on<AppEventShowUndoButtonAndDelete>((event, emit) async {
      try {
        await deleteTask(oldTask: event.taskModel);
        final listsList = await getLists();
        final tasksListBefore = await getTasks(
          listModel: event.listModel,
        );
        emit(LoadedAppState(
          isJustDeleted: true,
          tasksList: tasksListBefore,
          quoteModel: quote,
          listModel: event.listModel,
          listsList: listsList,
          deletedTask: event.taskModel,
        ));
        await Future.delayed(const Duration(seconds: 5));
        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventDeleteTask>((event, emit) async {
      try {
        await deleteTask(oldTask: event.taskModel);
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventMoveToTask>((event, emit) async {
      try {
        await moveToFromMainScreenTask(
          updatedTask: event.taskModel,
          moveToListModel: event.moveToListModel,
        );
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: listsList[selectedListIndex],
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: listsList[selectedListIndex],
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventDeleteList>((event, emit) async {
      await deleteList(oldList: event.listModel);
      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
            listsList: listsList,
            focusNodeList: focusNodeList,
            controllerList: controllerList),
      );
    });
    on<AppEventUpdateListColor>((event, emit) async {
      await updateListColor(
        oldList: event.listModel,
        listColorIndex: event.listColorIndex,
      );
      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
            listsList: listsList,
            focusNodeList: focusNodeList,
            controllerList: controllerList),
      );
    });
    on<AppEventUpdateListText>((event, emit) async {
      await updateListText(
        oldList: event.listModel,
        text: event.listText.trim(),
      );
      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
            listsList: listsList,
            focusNodeList: focusNodeList,
            controllerList: controllerList),
      );
    });
    on<AppEventChangeList>((event, emit) async {
      emit(LoadingAppState(
        listModel: event.listModel,
      ));
      try {
        selectedListIndex = event.index;
        final listsList = await getLists();

        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventAddNewListFromListScreen>((event, emit) async {
      final listsList =
          await createNewList(listController: event.listController);
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
            listsList: listsList,
            focusNodeList: focusNodeList,
            controllerList: controllerList),
      );
    });

    on<AppEventAddNewListFromMainScreen>((event, emit) async {
      try {
        await createNewList(listController: event.listController);
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: listsList[selectedListIndex],
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: listsList[selectedListIndex],
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });

    on<AppEventSetReminderFromTaskPage>((event, emit) async {
      final updatedTaskModel = await singleTaskReminderSet(
        chosenDateTime: event.dateTime,
        taskModel: event.taskModel,
        context: event.context,
      );
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
            listsList: listsList,
            taskModel: updatedTaskModel,
            isClosePanelTapped: currentUser.isClosePanelTapped,
            listModel: listsList[selectedListIndex]),
      );
    });

    on<AppEventSetReminderFromNewTaskPage>((event, emit) async {
      final TaskModel newTask = newTaskReminderSet(
        chosenDateTime: event.dateTime,
        taskModel: event.taskModel,
        context: event.context,
      );
      final listsList = await getLists();
      emit(
        AddNewTaskAppState(
          listsList: listsList,
          isReminderActive: newTask.isReminderActive,
          dateTimeReminder: newTask.dateTimeReminder,
        ),
      );
    });

    on<AppEventDeleteReminderFromTaskPage>((event, emit) async {
      final updatedTaskModel = await singleTaskReminderDelete(
          taskModel: event.taskModel, context: event.context);
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
            listsList: listsList,
            taskModel: updatedTaskModel,
            isClosePanelTapped: currentUser.isClosePanelTapped,
            listModel: listsList[selectedListIndex]),
      );
    });

    on<AppEventDeleteReminderFromNewTaskPage>((event, emit) async {
      final TaskModel newTask = newTaskReminderDelete(
        taskModel: event.taskModel,
        context: event.context,
      );
      final listsList = await getLists();
      emit(
        AddNewTaskAppState(
          listsList: listsList,
          isReminderActive: newTask.isReminderActive,
          dateTimeReminder: newTask.dateTimeReminder,
        ),
      );
    });
    on<AppEventChangePanelTapped>((event, emit) async {
      updateUserPanelTapped();
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
            listsList: listsList,
            taskModel: event.taskModel,
            isClosePanelTapped: true,
            listModel: listsList[selectedListIndex]),
      );
    });
    on<AppEventUpdateTask>((event, emit) async {
      emit(LoadingAppState(
        listModel: event.listModel,
      ));
      try {
        final listsList = await getLists();

        await updateTask(
          updatedTask: event.taskModel,
          moveToListModel: event.moveToListModel,
          textController: event.textController,
        );
        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });

    on<AppEventListPanelOpenFromMainView>((event, emit) async {
      try {
        final listsList = await getLists();
        CustomModalBottomSheet.showModalListsPanelWidgetFromMainView(
          context: event.context,
          heightScreen: event.heightScreen,
          widthScreen: event.widthScreen,
          listsList: listsList,
          onMoveToButtonPressed: event.onMoveToButtonPressed,
          onAddNewList: event.onAddNewList,
        );

        final tasksList = await getTasks(listModel: event.listModel);
        emit(
          LoadedAppState(
              listModel: event.listModel,
              tasksList: tasksList,
              quoteModel: quote,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });

    on<AppEventListPanelOpenFromTaskView>((event, emit) async {
      final listsList = await getLists();
      CustomModalBottomSheet.showModalListsPanelWidgetFromTaskView(
        context: event.context,
        heightScreen: event.heightScreen,
        widthScreen: event.widthScreen,
        listsList: listsList,
        onAddNewList: event.onAddNewList,
      );

      emit(
        SingleTaskAppState(
            isClosePanelTapped: currentUser.isClosePanelTapped,
            listsList: listsList,
            taskModel: event.taskModel,
            listModel: listsList[selectedListIndex]),
      );
    });

    on<AppEventAddNewListPanelOpenFromTaskView>((event, emit) async {
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: AddNewListPanelWidget(
            height: event.heightScreen,
            onTapClose: () {
              Navigator.of(event.context).pop();
            },
            width: event.widthScreen,
            onBlackButtonTap: (controller) {
              event.onBlackButtonPressed(controller);
            },
          ),
        ),
      );
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
            isClosePanelTapped: currentUser.isClosePanelTapped,
            listsList: listsList,
            taskModel: event.taskModel,
            listModel: listsList[selectedListIndex]),
      );
    });

    on<AppEventAddNewListPanelOpenFromMainView>((event, emit) async {
      try {
        CustomModalBottomSheet.showModalAddNewListPanelWidget(
          context: event.context,
          heightScreen: event.heightScreen,
          widthScreen: event.widthScreen,
          onBlackButtonPressed: (TextEditingController controller) {
            event.onBlackButtonPressed(controller);
          },
        );
        final tasksList = await getTasks(listModel: event.listModel);
        final listsList = await getLists();
        emit(
          LoadedAppState(
              listModel: event.listModel,
              tasksList: tasksList,
              quoteModel: quote,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });
    on<AppEventAddNewListPanelOpenFromListView>((event, emit) async {
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: AddNewListPanelWidget(
            height: event.heightScreen,
            onTapClose: () {
              Navigator.of(event.context).pop();
            },
            width: event.widthScreen,
            onBlackButtonTap: (controller) {
              event.onBlackButtonPressed(controller);
            },
          ),
        ),
      );
      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(LoadedListsAppState(
          listsList: listsList,
          focusNodeList: focusNodeList,
          controllerList: controllerList));
    });
    on<AppEventOpenReminderPanelFromTaskView>((event, emit) async {
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: ReminderPanelWidget(
            height: event.heightScreen,
            width: event.widthScreen,
            onCloseTap: Navigator.of(event.context).pop,
            onSaveTap: (DateTime? chosenDateTime) {
              event.onSaveTap(chosenDateTime);
            },
            taskModel: event.taskModel,
            onDeleteTap: () {
              event.onDeleteTap();
            },
          ),
        ),
      );
      final listsList = await getLists();
      emit(SingleTaskAppState(
          listsList: listsList,
          isClosePanelTapped: currentUser.isClosePanelTapped,
          taskModel: event.taskModel,
          listModel: listsList[selectedListIndex]));
    });

    on<AppEventOpenReminderPanelFromNewTaskView>((event, emit) async {
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: ReminderPanelWidget(
            height: event.heightScreen,
            width: event.widthScreen,
            onCloseTap: Navigator.of(event.context).pop,
            onSaveTap: (DateTime? chosenDateTime) {
              event.onSaveTap(chosenDateTime);
            },
            taskModel: event.taskModel,
            onDeleteTap: () {
              event.onDeleteTap();
            },
          ),
        ),
      );
      final listsList = await getLists();
      emit(AddNewTaskAppState(
          listsList: listsList,
          dateTimeReminder: event.taskModel.dateTimeReminder,
          isReminderActive: event.taskModel.isReminderActive));
    });

    on<AppEventOnListsTapFromNewTaskView>((event, emit) async {
      CustomModalBottomSheet.showModalColorsPanelWidget(
        context: event.context,
        heightScreen: event.heightScreen,
        widthScreen: event.widthScreen,
        listsList: event.lists,
        selectedIndex: event.selectedIndex,
        onAddNewListPressed: event.onAddNewListPressed,
      );

      final listsList = await getLists();
      emit(AddNewTaskAppState(
          dateTimeReminder: event.taskModel.dateTimeReminder,
          listsList: listsList,
          isReminderActive: event.taskModel.isReminderActive));
    });

    on<AppEventAddNewListPanelOpenFromNewTaskView>((event, emit) async {
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: AddNewListPanelWidget(
            height: event.heightScreen,
            onTapClose: () {
              Navigator.of(event.context).pop();
            },
            width: event.widthScreen,
            onBlackButtonTap: (controller) {
              event.onBlackButtonPressed(controller);
            },
          ),
        ),
      );
      final listsList = await getLists();
      emit(AddNewTaskAppState(
          listsList: listsList,
          dateTimeReminder: event.taskModel.dateTimeReminder,
          isReminderActive: event.taskModel.isReminderActive));
    });

    on<AppEventAddNewListFromNewTaskView>((event, emit) async {
      await createNewList(listController: event.listController);
      final taskModel = event.taskModel;
      final listsList = await getLists();
      emit(
        AddNewTaskAppState(
            listsList: listsList,
            dateTimeReminder: taskModel.dateTimeReminder,
            isReminderActive: taskModel.isReminderActive),
      );
    });

    on<AppEventNotification>((event, emit) async {
      final localNotifications = FlutterLocalNotificationsPlugin();
      //final firebaseMessaging = FirebaseMessaging();
      const androidInitialize = AndroidInitializationSettings('ic_launcher');
      const iOSInitialize = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      const initializationSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
      localNotifications.initialize(initializationSettings);
      showNotification(localNotifications);
    });

    on<AppEventOptionsPanelOpen>((event, emit) async {
      CustomModalBottomSheet.showModalOptionsPanelWidget(
          context: event.context,
          heightScreen: event.heightScreen,
          widthScreen: event.widthScreen,
          onRenameTap: event.onRenameTap,
          onDeleteTap: event.onDeleteTap,
          onThumbnailTap: event.onThumbnailTap,
          changeListColor: event.changeListColor,
          listsList: event.listsList,
          selectedIndex: event.selectedIndex);

      final listsList = await getLists();
      focusNodeList = List.generate(listsList.length, (index) => FocusNode());
      controllerList =
          List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(LoadedListsAppState(
          listsList: listsList,
          focusNodeList: focusNodeList,
          controllerList: controllerList));
    });

    on<AppEventUndoDeleteTask>((event, emit) async {
      try {
        addNewTask(
          text: event.taskModel.task,
          taskID: event.taskModel.taskID,
          colorIndex: event.taskModel.colorIndex,
          listID: event.taskModel.listID,
          dateTimeReminder: event.taskModel.dateTimeReminder,
          isReminderActive: event.taskModel.isReminderActive,
        );
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: event.listModel,
        );
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              listModel: event.listModel,
              listsList: listsList),
        );
      } on Exception {
        emit(const ErrorAppState());
      }
    });

    on<AppEventUpdateListImage>((event, emit) async {
      final int variable = await updateOrDeleteImageDialog(
          context: event.context, listModel: event.listModel);
      if (variable == 0) {
        final listsList = await getLists();
        focusNodeList = List.generate(listsList.length, (index) => FocusNode());
        controllerList =
            List.generate(listsList.length, (index) => TextEditingController());
        for (int i = 0; i < listsList.length; i++) {
          controllerList[i].text = listsList[i].list;
        }
        emit(
          LoadedListsAppState(
              listsList: listsList,
              focusNodeList: focusNodeList,
              controllerList: controllerList),
        );
      } else if (variable == 1) {
        deleteListImage(oldList: event.listModel);
        final listsList = await getLists();
        focusNodeList = List.generate(listsList.length, (index) => FocusNode());
        controllerList =
            List.generate(listsList.length, (index) => TextEditingController());
        for (int i = 0; i < listsList.length; i++) {
          controllerList[i].text = listsList[i].list;
        }
        emit(
          LoadedListsAppState(
              listsList: listsList,
              focusNodeList: focusNodeList,
              controllerList: controllerList),
        );
      } else if (variable == 2) {
        final File? imageFile = await chooseFileToListImage();
        if (imageFile == null) return;
        if (await showImagePickerDialog(
          context: event.context,
          imageFile: imageFile,
        )) {
          await updateListImage(
              listModel: event.listModel, imageFile: imageFile);
          final listsList = await getLists();
          focusNodeList =
              List.generate(listsList.length, (index) => FocusNode());
          controllerList = List.generate(
              listsList.length, (index) => TextEditingController());
          for (int i = 0; i < listsList.length; i++) {
            controllerList[i].text = listsList[i].list;
          }
          emit(
            LoadedListsAppState(
                listsList: listsList,
                focusNodeList: focusNodeList,
                controllerList: controllerList),
          );
        } //else if (variable == 3) {
        //   final XFile? takenPhoto = await takePhotoToListImage();
        //   if (takenPhoto == null) return;
        //   if (await showCameraImagePickerDialog(
        //     context: event.context,
        //     imageFile: takenPhoto,
        //   )) {
        //     await uploadListImageFromCamera(
        //         listModel: event.listModel, takenPhoto: takenPhoto);
        //     final listsList = await getLists();
        //     focusNodeList =
        //         List.generate(listsList.length, (index) => FocusNode());
        //     controllerList = List.generate(
        //         listsList.length, (index) => TextEditingController());
        //     for (int i = 0; i < listsList.length; i++) {
        //       controllerList[i].text = listsList[i].list;
        //     }
        //     emit(
        //       LoadedListsAppState(
        //           listsList: listsList,
        //           focusNodeList: focusNodeList,
        //           controllerList: controllerList),
        //     );
        //   }
        // }
      }
    });
  }

  @override
  Future<void> close() {
    for (var node in focusNodeList) {
      node.dispose();
    }
    for (var controller in controllerList) {
      controller.dispose();
    }
    return super.close();
  }
}
