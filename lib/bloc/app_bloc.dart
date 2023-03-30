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
      final focusNodeList =
          List.generate(listsList.length, (index) => FocusNode());
      final controllerList = List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(listsList: listsList, focusNodeList: focusNodeList, controllerList: controllerList),
      );
    });
    on<AppEventGoToNewTask>((event, emit) async {
      emit(
        AddNewTaskAppState(listsList: event.listsList),
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
      final focusNodeList =
          List.generate(listsList.length, (index) => FocusNode());
      final controllerList = List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(listsList: listsList, focusNodeList: focusNodeList, controllerList: controllerList),
      );
    });
    on<AppEventUpdateListColor>((event, emit) async {
      await updateListColor(
        oldList: event.listModel,
        listColorIndex: event.listColorIndex,
      );
      final listsList = await getLists();
      final focusNodeList =
          List.generate(listsList.length, (index) => FocusNode());
      final controllerList = List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(listsList: listsList, focusNodeList: focusNodeList, controllerList: controllerList),
      );
    });
    on<AppEventUpdateListText>((event, emit) async {
      await updateListText(
        oldList: event.listModel,
        text: event.listText,
      );
      final listsList = await getLists();
      final focusNodeList =
          List.generate(listsList.length, (index) => FocusNode());
      final controllerList = List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(listsList: listsList, focusNodeList: focusNodeList, controllerList: controllerList),
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
      final focusNodeList =
          List.generate(listsList.length, (index) => FocusNode());
      final controllerList = List.generate(listsList.length, (index) => TextEditingController());
      for (int i = 0; i < listsList.length; i++) {
        controllerList[i].text = listsList[i].list;
      }
      emit(
        LoadedListsAppState(
          listsList: listsList,
          focusNodeList: focusNodeList,
          controllerList: controllerList
        ),
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
  }
}
