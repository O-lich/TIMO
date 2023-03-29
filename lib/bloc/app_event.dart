part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventGetUser implements AppEvent {
  const AppEventGetUser() : super();
}

@immutable
class AppEventGoToLists implements AppEvent {
  const AppEventGoToLists() : super();
}

@immutable
class AppEventGoToSettings implements AppEvent {
  const AppEventGoToSettings() : super();
}

@immutable
class AppEventGoToLanguage implements AppEvent {
  const AppEventGoToLanguage() : super();
}

@immutable
class AppEventChangeLocale implements AppEvent {
  BuildContext context;
  int index;

  AppEventChangeLocale({
    required this.context,
    required this.index,
  }) : super();
}

@immutable
class AppEventGetLists implements AppEvent {
  final String userID;

  const AppEventGetLists({
    required this.userID,
  }) : super();
}

@immutable
class AppEventGetTasks implements AppEvent {
  final String userID;
  final String listID;

  const AppEventGetTasks({
    required this.userID,
    required this.listID,
  }) : super();
}

@immutable
class AppEventDeleteList implements AppEvent {
  final ListModel listModel;

  const AppEventDeleteList({
    required this.listModel,
  });
}

@immutable
class AppEventUpdateListColor implements AppEvent {
  final ListModel listModel;
  final int listColorIndex;

  const AppEventUpdateListColor({
    required this.listModel,
    required this.listColorIndex,
  });
}

@immutable
class AppEventUpdateList implements AppEvent {
  const AppEventUpdateList();
}

@immutable
class AppEventUpdateTask implements AppEvent {
  const AppEventUpdateTask();
}

@immutable
class AppEventMoveToTask implements AppEvent {
  final TaskModel taskModel;

  const AppEventMoveToTask({
    required this.taskModel,
  });
}

@immutable
class AppEventDeleteTask implements AppEvent {
  final TaskModel taskModel;

  const AppEventDeleteTask({
    required this.taskModel,
  });
}

@immutable
class AppEventAddNewTask implements AppEvent {
  final TextEditingController taskController;

  const AppEventAddNewTask({
    required this.taskController,
  });
}

@immutable
class AppEventAddNewListFromListScreen implements AppEvent {
  final TextEditingController listController;


  const AppEventAddNewListFromListScreen({
    required this.listController,

  });
}

@immutable
class AppEventAddNewListFromMainScreen implements AppEvent {
  final TextEditingController listController;
  final BuildContext context;

  const AppEventAddNewListFromMainScreen({
    required this.listController,
    required this.context,
  });
}

@immutable
class AppEventAddNewListFromTaskScreen implements AppEvent {
  final TextEditingController listController;
  final BuildContext context;
  final TaskModel taskModel;

  const AppEventAddNewListFromTaskScreen(
      {required this.listController,
      required this.context,
      required this.taskModel});
}

@immutable
class AppEventGoToNewTask implements AppEvent {
  const AppEventGoToNewTask() : super();
}

@immutable
class AppEventOpenListPanel implements AppEvent {
  final Widget widget;
  final BuildContext context;
  final List<ListModel> listsList;

  const AppEventOpenListPanel({
    required this.context,
    required this.widget,
    required this.listsList,
  }) : super();
}

@immutable
class AppEventGoToMainView implements AppEvent {
  const AppEventGoToMainView() : super();
}

@immutable
class AppEventGoToSingleTask implements AppEvent {
  final TaskModel taskModel;

  const AppEventGoToSingleTask({
    required this.taskModel,
  }) : super();
}

@immutable
class AppEventChangeList implements AppEvent {
  final int index;

  const AppEventChangeList({
    required this.index,
  }) : super();
}
