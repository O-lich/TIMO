import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';
import 'package:todo_app_main_screen/ui/screens/error_view.dart';
import 'package:todo_app_main_screen/ui/screens/language_view.dart';
import 'package:todo_app_main_screen/ui/screens/lists_view.dart';
import 'package:todo_app_main_screen/ui/screens/loading_view.dart';
import 'package:todo_app_main_screen/ui/screens/home_view.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_view.dart';
import 'package:todo_app_main_screen/ui/screens/premium_view.dart';
import 'package:todo_app_main_screen/ui/screens/settings_view.dart';
import 'package:todo_app_main_screen/ui/screens/splash_view.dart';
import 'package:todo_app_main_screen/ui/screens/task_view.dart';
import 'package:todo_app_main_screen/ui/widgets/alarm_notification_widget.dart';
import 'bloc/app_bloc.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
int taskCurrentColorIndex = -1;
UserModel currentUser = UserModel();
int selectedListIndex = 0;
int selectedTaskIndex = -1;
int moveToListIndex = -1;
QuoteModel quote = QuoteModel(author: 'author', content: 'content');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  currentUser = await UserModel.getUserModel();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return BlocProvider<AppBloc>(
            create: (_) => AppBloc()
              ..add(
                const AppEventGetUser(),
              ),
            child: MaterialApp(
              locale: provider.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: Locales.allLocales,
              theme: ThemeData(
                colorSchemeSeed: Colors.white,
                fontFamily: 'CeraPro',
              ),
              home: BlocConsumer<AppBloc, AppState>(
                listener: (context, appState) {},
                builder: (context, appState) {
                  if (appState is AppStateSplashScreen) {
                    return AnimatedSwitcher(
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(0, -0.2),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      switchOutCurve: const Threshold(0),
                      duration: const Duration(milliseconds: 4000),
                      child: Container(
                        key: UniqueKey(),
                        child: const SplashView(),
                      ),
                    );
                  } else if (appState is LoadedAppState) {
                    return HomeView(
                      deletedTask: appState.deletedTask,
                      isJustDeleted: appState.isJustDeleted,
                      quoteModel: appState.quoteModel,
                      tasksList: appState.tasksList,
                      listModel: appState.listModel,
                      listsList: appState.listsList,
                    );
                  } else if (appState is LoadedListsAppState) {
                    return ListsView(
                      listsList: appState.listsList,
                      focusNodeList: appState.focusNodeList,
                      controllerList: appState.controllerList,
                    );
                  } else if (appState is AddNewTaskAppState) {
                    return NewTaskView(
                      listsList: appState.listsList,
                      isReminderActive: appState.isReminderActive,
                      dateTimeReminder: appState.dateTimeReminder,
                    );
                  } else if (appState is SettingsAppState) {
                    return const SettingsView();
                  } else if (appState is LanguageAppState) {
                    return LanguageView(
                      selectedIndex: appState.locale,
                    );
                  } else if (appState is SingleTaskAppState) {
                    return TaskView(
                      taskModel: appState.taskModel,
                      listsList: appState.listsList,
                      isClosePanelTapped: appState.isClosePanelTapped,
                      listModel: appState.listModel,
                    );
                  } else if (appState is LoadingAppState) {
                    return LoadingView(
                      listModel: appState.listModel,
                    );
                  } else if (appState is ErrorAppState) {
                    return const ErrorView();
                  } else if (appState is PremiumAppState) {
                    return const PremiumView();
                  } else if (appState is AppNotificationAppState) {
                    return const AlarmNotifWidget(
                      content: 'alarm',
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        });
  }
}
