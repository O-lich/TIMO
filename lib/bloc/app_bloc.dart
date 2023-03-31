import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';

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
        await getUsers();
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: listsList[selectedListIndex],
        );
        final QuoteModel quote = await updateQuote();
        emit(
          LoadedAppState(
              tasksList: tasksList,
              quoteModel: quote,
              selectedListIndex: selectedListIndex,
              listsList: listsList),
        );
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
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
    });
    on<AppEventAddNewTask>((event, emit) async {
      createNewTask(
        taskController: event.taskController,
        currentList: event.listModel,
        dateTimeReminder: event.dateTimeReminder,
        isReminderActive: event.isReminderActive,
      );
      emit(const LoadingAppState());
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
    });
    on<AppEventGoToSettings>((event, emit) async {
      emit(
        const SettingsAppState(),
      );
    });
    on<AppEventGoToSingleTask>((event, emit) async {
      final taskModel = event.taskModel;
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
          taskModel: taskModel,
          listsList: listsList,
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
    on<AppEventDeleteTask>((event, emit) async {
      await deleteTask(oldTask: event.taskModel);
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
    });
    on<AppEventMoveToTask>((event, emit) async {
      await moveToFromMainScreenTask(
        updatedTask: event.taskModel,
        moveToListModel: event.moveToListModel,
      );
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
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
        text: event.listText,
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
      selectedListIndex = event.index;
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
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
      await createNewList(listController: event.listController);
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
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
        ),
      );
    });

    on<AppEventSetReminderFromNewTaskPage>((event, emit) async {
      final TaskModel newTask = newTaskReminderSet(
        chosenDateTime: event.dateTime,
        taskModel: event.taskModel,
        context: event.context,
      );
      final listsList = await getLists();
      emit(AddNewTaskAppState(
        listsList: listsList,
        isReminderActive: newTask.isReminderActive,
        dateTimeReminder: newTask.dateTimeReminder,
      ));
    });

    on<AppEventDeleteReminderFromTaskPage>((event, emit) async {
      final updatedTaskModel = await singleTaskReminderDelete(
          taskModel: event.taskModel, context: event.context);
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
          listsList: listsList,
          taskModel: updatedTaskModel,
        ),
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

    on<AppEventUpdateTask>((event, emit) async {
      log("AppEventUpdateTask");
      emit(const LoadingAppState());
      await updateTask(
        updatedTask: event.taskModel,
        moveToListModel: event.moveToListModel,
        textController: event.textController,
      );
      final listsList = await getLists();
      final tasksList = await getTasks(
        listModel: listsList[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex,
            listsList: listsList),
      );
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
