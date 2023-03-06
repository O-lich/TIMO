import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/screens/premium_page.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/screens/task_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CeraPro',
      ),
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        NewTaskPage.routeName: (context) => const NewTaskPage(),
        TaskPage.routeName: (context) => const TaskPage(),
        ListsPage.routeName: (context) => const ListsPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        LanguagePage.routeName: (context) => const LanguagePage(),
        PremiumPage.routeName: (context) => const PremiumPage()
      },
      initialRoute: MyHomePage.routeName,
    );
  }
}
