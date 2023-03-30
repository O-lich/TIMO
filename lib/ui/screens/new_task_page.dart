import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';

class NewTaskPage extends StatefulWidget {
  final List<ListModel> listsList;
  static const routeName = '/new_task_page';

  const NewTaskPage({
    Key? key,
    required this.listsList,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final taskController = TextEditingController();
  final listController = TextEditingController();
  final taskModel = TaskModel(task: '');
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        taskController: taskController,
        width: widthScreen,
        onBlackButtonPressed: () {
          context.read<AppBloc>().add(
                AppEventAddNewTask(
                  taskController: taskController,
                  listModel: widget.listsList[selectedListIndex],
                ),
              );
        },
        onListsTap: () {
          SlidingPanelHelper().onListsTap(
            context,
            widthScreen,
            heightScreen,
            widget.listsList,
            buttonColors,
            listController,
            taskCurrentColorIndex,
          );
        },
        onReminderTap: () {
          SlidingPanelHelper().onReminderTap(
            widthScreen,
            heightScreen,
            context,
            (DateTime? dateTime) {
              context.read<AppBloc>().add(
                    AppEventSetReminderFromNewTaskPage(
                        taskModel: taskModel,
                        dateTime: dateTime,
                        context: context),
                  );
            },
            (DateTime? dateTime) {
              context.read<AppBloc>().add(
                AppEventDeleteReminderFromNewTaskPage(
                    taskModel: taskModel,
                    dateTime: dateTime,
                    context: context),
              );
            },
            taskModel,
          );
        },
        onCloseTap: () {
          context.read<AppBloc>().add(
                const AppEventGoToMainView(),
              );
        },
      ),
    );
  }
}
