import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/add_new_list_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';

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
        final QuoteModel quote = await updateQuote();
        await getUsers();
        final listsList = await getLists();
        final tasksList = await getTasks(
          listModel: listsList[selectedListIndex],
        );
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
      emit(
        LoadingAppState(
          listModel: event.listModel,
          selectedListIndex: selectedListIndex,
        ),
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
    on<AppEventAddNewTask>((event, emit) async {
      emit(LoadingAppState(
          selectedListIndex: selectedListIndex,
          listModel: event.listModel));
      createNewTask(
        taskController: event.taskController,
        currentList: event.listModel,
        dateTimeReminder: event.dateTimeReminder,
        isReminderActive: event.isReminderActive,
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
          isClosePanelTapped: currentUser.isClosePanelTapped,
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
      emit(LoadingAppState(
        selectedListIndex: selectedListIndex,
        listModel: event.listModel,
      ));
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
          isClosePanelTapped: currentUser.isClosePanelTapped,
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
          isClosePanelTapped: currentUser.isClosePanelTapped,
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
    on<AppEventChangePanelTapped>((event, emit) async {
      updateUserPanelTapped();
      final listsList = await getLists();
      emit(
        SingleTaskAppState(
          listsList: listsList,
          taskModel: event.taskModel,
          isClosePanelTapped: true,
        ),
      );
    });
    on<AppEventUpdateTask>((event, emit) async {
      emit(LoadingAppState(
        selectedListIndex: selectedListIndex,
        listModel: event.listModel,
      ));
      final listsList = await getLists();

      await updateTask(
        updatedTask: event.taskModel,
        moveToListModel: event.moveToListModel,
        textController: event.textController,
      );
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

    on<AppEventListPanelOpenFromMainView>((event, emit) async {
      final listsList = await getLists();
      final tasksList = await getTasks(listModel: event.listModel);
      final QuoteModel quote = await updateQuote();
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: ListsPanelWidget(
            onButtonPressed: () {
              event.onMoveToButtonPressed();
              Navigator.pop(context);
            },
            height: event.heightScreen,
            width: event.widthScreen,
            lists: listsList,
            onTapClose: Navigator.of(context).pop,
            onAddNewListPressed: () {
              event.onAddNewList();
            },
          ),
        ),
      );
      emit(LoadedAppState(
          selectedListIndex: selectedListIndex,
          tasksList: tasksList,
          quoteModel: quote,
          listsList: listsList));
    });

    on<AppEventListPanelOpenFromTaskView>((event, emit) async {
      final listsList = await getLists();
      showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        enableDrag: false,
        context: event.context,
        builder: (context) => SingleChildScrollView(
          controller: ModalScrollController.of(context),
          child: ListsPanelWidget(
            onButtonPressed: Navigator.of(context).pop,
            height: event.heightScreen,
            width: event.widthScreen,
            lists: listsList,
            onTapClose: Navigator.of(context).pop,
            onAddNewListPressed: () {
              event.onAddNewList();
            },
          ),
        ),
      );
      emit(SingleTaskAppState(
          isClosePanelTapped: currentUser.isClosePanelTapped,
          listsList: listsList,
          taskModel: event.taskModel));
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
      emit(SingleTaskAppState(
          isClosePanelTapped: currentUser.isClosePanelTapped,
          listsList: listsList,
          taskModel: event.taskModel));
    });

    on<AppEventAddNewListPanelOpenFromMainView>((event, emit) async {
      final tasksList = await getTasks(listModel: event.listModel);
      final QuoteModel quote = await updateQuote();
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
      emit(LoadedAppState(
          selectedListIndex: selectedListIndex,
          tasksList: tasksList,
          quoteModel: quote,
          listsList: listsList));
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
