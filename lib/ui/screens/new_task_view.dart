import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';

class NewTaskView extends StatefulWidget {
  final List<ListModel> listsList;
  final bool isReminderActive;
  final String dateTimeReminder;

  static const routeName = '/new_task_page';

  const NewTaskView({
    Key? key,
    required this.listsList,
    required this.isReminderActive,
    required this.dateTimeReminder,
  }) : super(key: key);

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  final taskController = TextEditingController();
  final listController = TextEditingController();
  final taskModel = TaskModel(task: '');
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        isReminderActive: widget.isReminderActive,
        taskController: taskController,
        width: widthScreen,
        onBlackButtonPressed: () {
          context.read<AppBloc>().add(
                AppEventAddNewTask(
                  taskColorIndex: taskCurrentColorIndex,
                  taskController: taskController,
                  listModel: moveToListIndex >= 0
                      ? widget.listsList[moveToListIndex]
                      : widget.listsList[selectedListIndex],
                  isReminderActive: widget.isReminderActive,
                  dateTimeReminder: widget.dateTimeReminder,
                ),
              );
          if (moveToListIndex >= 0) {
            selectedListIndex = moveToListIndex;
          }
        },
        onListsTap: () {
          onListTap(heightScreen, widthScreen, context);
        },
        onReminderTap: () {
          context.read<AppBloc>().add(
                AppEventOpenReminderPanelFromNewTaskView(
                  taskModel: taskModel,
                  context: context,
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  onSaveTap: (DateTime? dateTime) {
                    context.read<AppBloc>().add(
                          AppEventSetReminderFromNewTaskPage(
                              taskModel: taskModel,
                              dateTime: dateTime,
                              context: context),
                        );
                  },
                  onDeleteTap: () {
                    context.read<AppBloc>().add(
                          AppEventDeleteReminderFromNewTaskPage(
                              taskModel: taskModel, context: context),
                        );
                  },
                ),
              );
        },
        onCloseTap: () {
          context.read<AppBloc>().add(
                AppEventGoToMainView(
                    listModel: widget.listsList[selectedListIndex]),
              );
        },
      ),
    );
  }

  void onListTap(
      double heightScreen, double widthScreen, BuildContext context) {
    context.read<AppBloc>().add(
          AppEventOnListsTapFromNewTaskView(
            taskModel: taskModel,
            context: context,
            heightScreen: heightScreen,
            widthScreen: widthScreen,
            lists: widget.listsList,
            buttonColors: buttonColors,
            controller: taskController,
            selectedIndex: taskModel.colorIndex,
            onAddNewListPressed: () => context
                .read<AppBloc>()
                .add(AppEventAddNewListPanelOpenFromNewTaskView(
                  taskModel: taskModel,
                  context: context,
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  onBlackButtonPressed: (TextEditingController controller) {
                    Navigator.pop(context);
                    context.read<AppBloc>().add(
                          AppEventAddNewListFromNewTaskView(
                            listController: controller,
                            context: context,
                            taskModel: taskModel,
                          ),
                        );
                    Navigator.pop(context);
                    onListTap(heightScreen, widthScreen, context);
                  },
                )),
          ),
        );
  }
}
