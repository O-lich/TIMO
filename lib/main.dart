import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/loading_view.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/screens/splash_view.dart';
import 'package:todo_app_main_screen/ui/screens/task_page.dart';
import 'bloc/app_bloc.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
int taskCurrentColorIndex = -1;
UserModel currentUser = UserModel();
int selectedListIndex = 0;
int selectedTaskIndex = -1;
int moveToListIndex = -1;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  currentUser = await UserModel.getUserModel();
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
                    return MyHomePage(
                      quoteModel: appState.quoteModel,
                      tasksList: appState.tasksList,
                      selectedListIndex: appState.selectedListIndex,
                      listsList: appState.listsList,
                    );
                  } else if (appState is LoadedListsAppState) {
                    return ListsPage(
                      listsList: appState.listsList,
                      focusNodeList: appState.focusNodeList,
                      controllerList: appState.controllerList,
                    );
                  } else if (appState is AddNewTaskAppState) {
                    return NewTaskPage(
                      listsList: appState.listsList,
                      isReminderActive: appState.isReminderActive,
                      dateTimeReminder: appState.dateTimeReminder,
                    );
                  } else if (appState is SettingsAppState) {
                    return const SettingsPage();
                  } else if (appState is LanguageAppState) {
                    return LanguagePage(
                      selectedIndex: appState.locale,
                    );
                  } else if (appState is SingleTaskAppState) {
                    return TaskPage(
                      taskModel: appState.taskModel,
                      listsList: appState.listsList,
                      isClosePanelTapped: appState.isClosePanelTapped,
                    );
                  } else if (appState is LoadingAppState) {
                    return LoadingView(
                      selectedListIndex: appState.selectedListIndex,
                      listModel: appState.listModel,
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
