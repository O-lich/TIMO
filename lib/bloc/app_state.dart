part of 'app_bloc.dart';

@immutable
abstract class AppState {
  const AppState();
}

@immutable
class InitAppState extends AppState {
  final QuoteModel quoteModel;

  const InitAppState({required this.quoteModel});
}

@immutable
class LoadingAppState extends AppState {
  final ListModel listModel;
  final int selectedListIndex;

  const LoadingAppState({
    required this.listModel,
    required this.selectedListIndex,
  });
}

@immutable
class AppStateSplashScreen extends AppState {
  const AppStateSplashScreen();
}

@immutable
class LoadedAppState extends AppState {
  final QuoteModel quoteModel;
  final List<TaskModel> tasksList;
  final int selectedListIndex;
  final List<ListModel> listsList;

  const LoadedAppState(
      {required this.selectedListIndex,
      required this.tasksList,
      required this.quoteModel,
      required this.listsList});
}

@immutable
class LoadedListsAppState extends AppState {
  final List<ListModel> listsList;
  final List<FocusNode> focusNodeList;
  final List<TextEditingController> controllerList;

  const LoadedListsAppState(
      {required this.listsList,
      required this.focusNodeList,
      required this.controllerList});
}

@immutable
class SettingsAppState extends AppState {
  const SettingsAppState();
}

@immutable
class AddNewTaskAppState extends AppState {
  final List<ListModel> listsList;
  final bool isReminderActive;
  final String dateTimeReminder;

  const AddNewTaskAppState({
    required this.dateTimeReminder,
    required this.listsList,
    required this.isReminderActive,
  });
}

@immutable
class LanguageAppState extends AppState {
  final int locale;

  const LanguageAppState({required this.locale});
}

@immutable
class ErrorAppState extends AppState {
  const ErrorAppState();
}

@immutable
class SingleTaskAppState extends AppState {
  final TaskModel taskModel;
  final List<ListModel> listsList;
  final bool isClosePanelTapped;

  const SingleTaskAppState({
    required this.isClosePanelTapped,
    required this.listsList,
    required this.taskModel,
  });
}
