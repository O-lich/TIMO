//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';

class HomeView extends StatefulWidget {
  final bool isJustDeleted;
  final QuoteModel quoteModel;
  final List<TaskModel> tasksList;
  final ListModel listModel;
  final List<ListModel> listsList;
  final TaskModel? deletedTask;

  static const routeName = '/my_home_page';

  const HomeView({
    Key? key,
    required this.quoteModel,
    required this.tasksList,
    required this.listsList,
    required this.listModel,
    this.isJustDeleted = false,
    this.deletedTask,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  bool isMoveTo = false; //manage add floating action button visibility
  final scrollController = ScrollController();
  final listController = TextEditingController();
  final dragController = DraggableScrollableController();
  bool isPanelDraggable = true;
  bool fabVisibility = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: dragController.isAttached &&
                dragController.pixels ==
                    MediaQuery.of(context).size.height * 0.95
            ? Colors.white
            : (widget.listsList.isNotEmpty)
                ? buttonColors[widget.listModel.listColorIndex]
                : buttonColors[0],
        body: Stack(
          fit: StackFit.expand,
          children: [
            MainScreenBackgroundWidget(
              width: widthScreen,
              height: heightScreen,
              onPressed: () {
                context.read<AppBloc>().add(
                      const AppEventGoToLists(),
                    );
              },
              quoteModel: widget.quoteModel,
              buttonColor: (widget.listsList.isNotEmpty)
                  ? buttonColors[widget.listModel.listColorIndex]
                  : buttonColors[0],
            ),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification dsNotification) {
                if (fabVisibility && dsNotification.extent >= 0.95) {
                  setState(() {
                    fabVisibility = false;
                  });
                } else if (!fabVisibility && dsNotification.extent < 0.95) {
                  setState(() {
                    fabVisibility = true;
                  });
                }
                return fabVisibility;
              },
              child: DraggableScrollableSheet(
                  controller: dragController,
                  minChildSize: 0.58,
                  maxChildSize: 0.95,
                  initialChildSize: 0.581,
                  builder: (context, scrollCtrl) {
                    return TasksWidget(
                      listModel: widget.listsList[selectedListIndex],
                      onMoveToPressed: () =>
                          onMoveToPressed(heightScreen, widthScreen, context),
                      isPanelOpen: fabVisibility,
                      tasksList: widget.tasksList,
                      scrollController: scrollCtrl,
                      height: fabVisibility == false
                          ? 0.95 * heightScreen
                          : 0.55 * heightScreen,
                      isMoveToPressed: isMoveTo,
                      dragController: dragController,
                      onTaskTap: (index) {
                        context.read<AppBloc>().add(
                              AppEventGoToSingleTask(
                                  taskModel: widget.tasksList[index]),
                            );
                      },
                      onNewTaskAddPressed: () {
                        context.read<AppBloc>().add(
                              AppEventGoToNewTask(
                                listsList: widget.listsList,
                              ),
                            );
                      },
                      onDelete: (TaskModel taskModel) {
                        context.read<AppBloc>().add(
                              AppEventShowUndoButtonAndDelete(
                                taskModels: widget.tasksList,
                                taskModel: taskModel,
                                listModel: widget.listModel,
                                listsList: widget.listsList,
                              ),
                            );
                      },
                    );
                  }),
            ),
          ],
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isJustDeleted
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: heightScreen * 0.036),
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 1, end: 0.0)
                            .animate(_controller),
                        child: FloatingActionButton(
                          backgroundColor: textColor,
                          onPressed: () {
                            _controller.forward().whenComplete(() {
                              setState(() {
                                _controller.reset();
                              });
                            });
                            context.read<AppBloc>().add(
                                  AppEventUndoDeleteTask(
                                      listModel: widget.listModel,
                                      listsList: widget.listsList,
                                      taskModel: widget.deletedTask!,
                                      taskModels: widget.tasksList),
                                );
                          },
                          heroTag: "fab1",
                          child: Image.asset(
                            AppIcons.undo,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            isMoveTo
                ? Container()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: textColor,
                      onPressed: () {
                        context.read<AppBloc>().add(
                              AppEventGoToNewTask(
                                listsList: widget.listsList,
                              ),
                            );
                      },
                      heroTag: "fab2",
                      child: Image.asset(
                        AppIcons.addButton,
                      ),
                    ),
                  ),
          ],
        ),
        // floatingActionButton: isMoveTo
        //     ? Container()
        //     : FloatingActionButton(
        //         heroTag: "fab2",
        //         backgroundColor: textColor,
        //         onPressed: () {
        //           context.read<AppBloc>().add(
        //                 AppEventGoToNewTask(
        //                   listsList: widget.listsList,
        //                 ),
        //               );
        //         },
        //         child: Image.asset(
        //           AppIcons.addButton,
        //         ),
        //       ),
      );
    });
  }

  void onMoveToPressed(
      double heightScreen, double widthScreen, BuildContext context) {
    context.read<AppBloc>().add(
          AppEventListPanelOpenFromMainView(
            listsList: widget.listsList,
            listModel: widget.listsList[selectedListIndex],
            context: context,
            heightScreen: heightScreen,
            widthScreen: widthScreen,
            onAddNewList: () {
              context.read<AppBloc>().add(
                    AppEventAddNewListPanelOpenFromMainView(
                      listModel: widget.listsList[selectedListIndex],
                      context: context,
                      heightScreen: heightScreen,
                      widthScreen: widthScreen,
                      onBlackButtonPressed: (TextEditingController controller) {
                        Navigator.pop(context);
                        context
                            .read<AppBloc>()
                            .add(AppEventAddNewListFromMainScreen(
                              listController: controller,
                              context: context,
                              listModel: widget.listsList[selectedListIndex],
                            ));
                        Navigator.pop(context);
                        onMoveToPressed(heightScreen, widthScreen, context);
                      },
                    ),
                  );
            },
            onMoveToButtonPressed: () {
              moveToListIndex == -1
                  ? isMoveTo = false
                  : context.read<AppBloc>().add(
                        AppEventMoveToTask(
                            moveToListModel: widget.listsList[moveToListIndex],
                            taskModel: widget.tasksList[selectedTaskIndex]),
                      );
              //Navigator.pop(context);
            },
          ),
        );
  }
}
