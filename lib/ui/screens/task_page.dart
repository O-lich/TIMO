import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/task_page_widgets/task_page_background_widget.dart';

class TaskPage extends StatefulWidget {
  static const routeName = '/task_page';
  final TaskModel taskModel;
  final List<ListModel> listsList;
  final bool isClosePanelTapped;

  const TaskPage({
    Key? key,
    required this.taskModel,
    required this.listsList,
    required this.isClosePanelTapped,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final listController = TextEditingController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: TaskPageBackgroundWidget(
        height: heightScreen,
        width: widthScreen,
        isClosePanelTapped: widget.isClosePanelTapped,
        onReminderTap: () => SlidingPanelHelper().onReminderTap(
          widthScreen: widthScreen,
          heightScreen: heightScreen,
          taskModel: widget.taskModel,
          context: context,
          onDeleteTap: () {
            context.read<AppBloc>().add(
                  AppEventDeleteReminderFromTaskPage(
                      taskModel: widget.taskModel, context: context),
                );
          },
          onSaveTap: (DateTime? dateTime) {
            context.read<AppBloc>().add(
                  AppEventSetReminderFromTaskPage(
                      taskModel: widget.taskModel,
                      dateTime: dateTime,
                      context: context),
                );
          },
        ),
        onTitleTap: () {},
        onMoveToTap: () {},
        colorsList: buttonColors,
        taskController: textController,
        taskModel: widget.taskModel,
        onCloseTap: () {
          context.read<AppBloc>().add(
                AppEventUpdateTask(
                    listModel: widget.listsList[selectedListIndex],
                    taskModel: widget.taskModel,
                    moveToListModel: moveToListIndex >= 0
                        ? widget.listsList[moveToListIndex]
                        : null,
                    textController: textController),
              );
        },
        onClosePanelTap: () {
          context.read<AppBloc>().add(
                AppEventChangePanelTapped(
                  taskModel: widget.taskModel,
                  isClosePanelTapped: true,
                ),
              );
        },
      ),
      floatingActionButton: showFab
          ? Container(
              padding: EdgeInsets.only(
                left: widthScreen * 0.1,
                right: widthScreen * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'deleteBtn',
                    elevation: 0,
                    backgroundColor: removeColor,
                    onPressed: () {
                      context.read<AppBloc>().add(
                            AppEventDeleteTask(taskModel: widget.taskModel),
                          );
                    },
                    child: Image.asset(
                      AppIcons.delete,
                      scale: 2.5,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'moveBtn',
                    elevation: 0,
                    backgroundColor: textColor,
                    onPressed: () => onMoveToPressed(heightScreen, widthScreen, context),
                    child: Image.asset(
                      AppIcons.moveTo,
                      scale: 3,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  void onMoveToPressed(
      double heightScreen, double widthScreen, BuildContext context) {
    context.read<AppBloc>().add(AppEventListPanelOpenFromTaskView(
        taskModel: widget.taskModel,
        context: context,
        heightScreen: heightScreen,
        widthScreen: widthScreen,
        onAddNewList: () {
          context.read<AppBloc>().add(AppEventAddNewListPanelOpenFromTaskView(
                taskModel: widget.taskModel,
                context: context,
                heightScreen: heightScreen,
                widthScreen: widthScreen,
                onBlackButtonPressed: (TextEditingController controller) {
                  Navigator.pop(context);
                  context.read<AppBloc>().add(AppEventAddNewListFromTaskScreen(
                      listController: controller,
                      context: context,
                      taskModel: widget.taskModel));
                  Navigator.pop(context);
                  onMoveToPressed(heightScreen, widthScreen, context);
                },
              ));
        }));
  }
}
