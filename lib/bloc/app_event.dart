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
  final BuildContext context;
  final int index;

  const AppEventChangeLocale({
    required this.context,
    required this.index,
  }) : super();
}

@immutable
class AppEventChangePanelTapped implements AppEvent {
  final bool isClosePanelTapped;
  final TaskModel taskModel;

  const AppEventChangePanelTapped({
    required this.taskModel,
    required this.isClosePanelTapped,
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
class AppEventUpdateListText implements AppEvent {
  final ListModel listModel;
  final String listText;

  const AppEventUpdateListText({
    required this.listModel,
    required this.listText,
  });
}

@immutable
class AppEventUpdateTask implements AppEvent {
  final TaskModel taskModel;
  final ListModel? moveToListModel;
  final TextEditingController textController;
  final ListModel listModel;

  const AppEventUpdateTask({
    required this.listModel,
    required this.taskModel,
    required this.moveToListModel,
    required this.textController,
  });
}

@immutable
class AppEventMoveToTask implements AppEvent {
  final TaskModel taskModel;
  final ListModel moveToListModel;

  const AppEventMoveToTask({
    required this.moveToListModel,
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
  final ListModel listModel;
  final bool isReminderActive;
  final String dateTimeReminder;

  const AppEventAddNewTask({
    required this.isReminderActive,
    required this.dateTimeReminder,
    required this.listModel,
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
  final ListModel listModel;

  const AppEventAddNewListFromMainScreen({
    required this.listController,
    required this.context,
    required this.listModel,
  });
}

@immutable
class AppEventAddNewListFromTaskScreen implements AppEvent {
  final TextEditingController listController;
  final BuildContext context;
  final TaskModel taskModel;

  const AppEventAddNewListFromTaskScreen({
    required this.listController,
    required this.context,
    required this.taskModel,
  });
}

@immutable
class AppEventGoToNewTask implements AppEvent {
  final List<ListModel> listsList;

  const AppEventGoToNewTask({
    required this.listsList,
  }) : super();
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
  final ListModel listModel;

  const AppEventGoToMainView({required this.listModel}) : super();
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
  final ListModel listModel;
  final int index;

  const AppEventChangeList({
    required this.listModel,
    required this.index,
  }) : super();
}

@immutable
class AppEventSetReminderFromTaskPage implements AppEvent {
  final TaskModel taskModel;
  final DateTime? dateTime;
  final BuildContext context;

  const AppEventSetReminderFromTaskPage({
    required this.taskModel,
    required this.dateTime,
    required this.context,
  }) : super();
}

@immutable
class AppEventSetReminderFromNewTaskPage implements AppEvent {
  final TaskModel taskModel;
  final DateTime? dateTime;
  final BuildContext context;

  const AppEventSetReminderFromNewTaskPage({
    required this.taskModel,
    required this.dateTime,
    required this.context,
  }) : super();
}

@immutable
class AppEventDeleteReminderFromTaskPage implements AppEvent {
  final TaskModel taskModel;
  final BuildContext context;

  const AppEventDeleteReminderFromTaskPage({
    required this.taskModel,
    required this.context,
  }) : super();
}

@immutable
class AppEventDeleteReminderFromNewTaskPage implements AppEvent {
  final TaskModel taskModel;
  final BuildContext context;

  const AppEventDeleteReminderFromNewTaskPage({
    required this.taskModel,
    required this.context,
  }) : super();
}

@immutable
class AppEventListPanelOpenFromTaskView implements AppEvent {
  final BuildContext context;
  final TaskModel taskModel;
  final double heightScreen;
  final double widthScreen;
  final void Function() onAddNewList;

  const AppEventListPanelOpenFromTaskView({
    required this.context,
    required this.taskModel,
    required this.heightScreen,
    required this.widthScreen,
    required this.onAddNewList,
  }) : super();
}

@immutable
class AppEventAddNewListPanelOpenFromTaskView implements AppEvent {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final void Function(TextEditingController controller) onBlackButtonPressed;
  final TaskModel taskModel;

  const AppEventAddNewListPanelOpenFromTaskView({
    required this.context,
    required this.heightScreen,
    required this.widthScreen,
    required this.onBlackButtonPressed,
    required this.taskModel,
  }) : super();
}

@immutable
class AppEventListPanelOpenFromMainView implements AppEvent {
  final BuildContext context;
  final ListModel listModel;
  final double heightScreen;
  final double widthScreen;
  final void Function() onAddNewList;
  final void Function() onMoveToButtonPressed;

  const AppEventListPanelOpenFromMainView({
    required this.onMoveToButtonPressed,
    required this.context,
    required this.listModel,
    required this.heightScreen,
    required this.widthScreen,
    required this.onAddNewList,
  }) : super();
}

@immutable
class AppEventAddNewListPanelOpenFromMainView implements AppEvent {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final void Function(TextEditingController controller) onBlackButtonPressed;
  final ListModel listModel;

  const AppEventAddNewListPanelOpenFromMainView({
    required this.context,
    required this.heightScreen,
    required this.widthScreen,
    required this.onBlackButtonPressed,
    required this.listModel,
  }) : super();
}
