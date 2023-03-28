import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/task_page_widgets/task_page_background_widget.dart';

class TaskPage extends StatefulWidget {
  static const routeName = '/task_page';
  final TaskModel taskModel;

  const TaskPage({
    Key? key, required this.taskModel,
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
        onReminderTap: () => SlidingPanelHelper().onReminderTap(
          widthScreen,
          heightScreen,
          context,
          () {},
          widget.taskModel,
        ),
        onTitleTap: () {},
        onMoveToTap: () {},
        colorsList: buttonColors,
        taskController: textController,
        taskModel: widget.taskModel,
        onCloseTap: () {
          updateTask(
            updatedTask: widget.taskModel,
          );
          //ToDo just for closing
          context.read<AppBloc>().add(
            const AppEventGoToMainView(
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
                    onPressed: () =>
                        SlidingPanelHelper().onPressedShowBottomSheet(
                      ListsPanelWidget(
                        height: heightScreen,
                        width: widthScreen,
                        lists: currentLists,
                        onTapClose: Navigator.of(context).pop,
                        onAddNewListPressed: () {
                          SlidingPanelHelper().onAddNewListPressed(
                            widthScreen: widthScreen,
                            heightScreen: heightScreen,
                            context: context,
                            onBlackButtonTap: (listController) {
                              Navigator.pop(context);
                              context.read<AppBloc>().add(
                                AppEventAddNewListFromTaskScreen(
                                    listController: listController,
                                    context: context, taskModel: widget.taskModel),
                              );
                            },
                          );
                        },
                        onButtonPressed: Navigator.of(context).pop,
                      ),
                      context,
                    ),
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



  Future<void> updateTask({
    required TaskModel updatedTask,
  }) async {
    if (selectedListIndex == moveToListIndex || moveToListIndex == -1) {
      final docRef = db
          .collection("users")
          .doc(updatedTask.userID)
          .collection('lists')
          .doc(updatedTask.listID)
          .collection('tasks')
          .doc(updatedTask.taskID);

      final updates = <String, dynamic>{
        'task': textController.text,
        'colorIndex': (taskCurrentColorIndex == -1)
            ? updatedTask.colorIndex
            : taskCurrentColorIndex,
      };
      docRef.update(updates);
    } else {
      db
          .collection("users")
          .doc(updatedTask.userID)
          .collection('lists')
          .doc(updatedTask.listID)
          .collection('tasks')
          .doc(updatedTask.taskID)
          .delete()
          .then(
            (doc) => log("Document deleted"),
            onError: (e) => log("Error updating document $e"),
          );
      addNewTaskUpdate(
        newTask: TaskModel(
          task: textController.text,
          colorIndex: (taskCurrentColorIndex == -1)
              ? updatedTask.colorIndex
              : taskCurrentColorIndex,
          listID: currentLists[moveToListIndex].listID,
          dateTimeReminder: updatedTask.dateTimeReminder,
          userID: updatedTask.userID,
          isReminderActive: updatedTask.isReminderActive,
          taskID: updatedTask.taskID,
        ),
      );
    }
    moveToListIndex = -1;
    taskCurrentColorIndex = -1;
  }


}
