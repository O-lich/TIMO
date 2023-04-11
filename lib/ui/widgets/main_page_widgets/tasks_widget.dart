import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/single_task_widget.dart';

class TasksWidget extends StatefulWidget {
  final ListModel listModel;
  bool isPanelOpen;
  final double height;
  final List<TaskModel> tasksList;
  final ScrollController scrollController;
  final DraggableScrollableController dragController;
  final void Function()? onMoveToPressed;
  final void Function() onTaskTap;
  final void Function() onNewTaskAddPressed;
  final bool isMoveToPressed;
  bool isPanelDraggable;

  TasksWidget({
    Key? key,
    required this.listModel,
    required this.isPanelOpen,
    required this.tasksList,
    required this.scrollController,
    this.onMoveToPressed,
    required this.height,
    required this.isMoveToPressed,
    this.isPanelDraggable = true,
    required this.dragController,
    required this.onTaskTap,
    required this.onNewTaskAddPressed,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = widget.tasksList;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(
        right: 25,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 22,
                ),
              ),
              todoButton(),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: 0.9 * widget.height,
              child: widget.tasksList.isEmpty
                  ? ListView(
                      controller: widget.scrollController,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextButton(
                              onPressed: widget.onNewTaskAddPressed,
                              child: Text(
                                S.of(context).letsDoSmth,
                                style: const TextStyle(
                                    fontSize: 46,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : ReorderableListView.builder(
                      physics: widget.isPanelOpen
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollController: widget.scrollController,
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      onReorder: reorderData,
                      itemBuilder: (BuildContext context, int index) {
                        return widget.isMoveToPressed == false
                            ? Slidable(
                                key: ValueKey(tasks[index]),
                                closeOnScroll: false,
                                endActionPane: ActionPane(
                                  extentRatio: 0.35,
                                  dismissible: DismissiblePane(
                                    onDismissed: () {
                                      _undo(tasks, index);
                                    },
                                  ),
                                  motion: const ScrollMotion(),
                                  children: [
                                    CustomSlidableAction(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      onPressed: (BuildContext context) {
                                        setState(() {});
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedTaskIndex = index;
                                          });
                                          widget.onMoveToPressed!();
                                        },
                                        child: Image.asset(
                                          AppIcons.moveTo,
                                          scale: 2.9,
                                        ),
                                      ),
                                    ),
                                    CustomSlidableAction(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      onPressed: (BuildContext context) {
                                        setState(() {

                                          _undo(tasks, index);
                                        });
                                      },
                                      child: Image.asset(
                                        AppIcons.delete,
                                        scale: 2.9,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    child: SingleTaskWidget(
                                      taskModel: widget.tasksList[index],
                                      onSingleTaskTap: () {
                                        context.read<AppBloc>().add(
                                              AppEventGoToSingleTask(
                                                  taskModel:
                                                      widget.tasksList[index]),
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                key: ValueKey(tasks[index]),
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Card(
                                  elevation: 0,
                                  child: SingleTaskWidget(
                                    taskModel: widget.tasksList[index],
                                    onSingleTaskTap: () {
                                      context.read<AppBloc>().add(
                                            AppEventGoToSingleTask(
                                              taskModel:
                                                  widget.tasksList[index],
                                            ),
                                          );
                                    },
                                  ),
                                ),
                              );
                      }),
            ),
          ),
        ],
      ),
    );
  }

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = widget.tasksList.removeAt(oldIndex);
      widget.tasksList.insert(newIndex, items);
    });
  }

  Widget todoButton() {
    return widget.isPanelOpen
        ? const SizedBox(
            height: 22,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 25, top: 15),
            child: InkWell(
              onTap: () {
                widget.dragController.jumpTo(0.58);
                widget.isPanelOpen = false;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    AppIcons.arrowClose,
                    scale: 3,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: Text(
                      widget.listModel.list,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _undo(List<TaskModel> tasks, int index) {
    Duration duration = const Duration(seconds: 5);
    TaskModel deletedItem = tasks[index];
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder<Duration>(
            duration: duration,
            tween: Tween(begin: duration, end: Duration.zero),
            onEnd: () {
              Navigator.of(context).pop(true);
              context.read<AppBloc>().add(
                    AppEventDeleteTask(taskModel: deletedItem),
                  );
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final seconds = value.inSeconds % 60;
              return CupertinoAlertDialog(
                title: Text(S.of(context).deletingTask(seconds)),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                      child: Text(S.of(context).undo),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: Text(S.of(context).delete),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<AppBloc>().add(
                              AppEventDeleteTask(taskModel: deletedItem),
                            );
                      }),
                ],
              );
            });
      },
    );
  }
}
