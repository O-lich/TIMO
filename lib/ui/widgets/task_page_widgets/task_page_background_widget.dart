import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/colors_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/shake_error_widget.dart';

class TaskPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final TaskModel taskModel;
  final void Function() onReminderTap;
  final void Function() onTitleTap;
  final void Function() onMoveToTap;
  final void Function() onCloseTap;
  final List<Color> colorsList;
  final TextEditingController taskController;
  final bool isClosePanelTapped;
  final void Function() onClosePanelTap;

  const TaskPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onReminderTap,
    required this.onTitleTap,
    required this.onMoveToTap,
    required this.colorsList,
    required this.taskController,
    required this.taskModel,
    required this.onCloseTap,
    required this.isClosePanelTapped,
    required this.onClosePanelTap,
  }) : super(key: key);

  @override
  State<TaskPageBackgroundWidget> createState() =>
      _TaskPageBackgroundWidgetState();
}

class _TaskPageBackgroundWidgetState extends State<TaskPageBackgroundWidget> {
  bool isTapped = false;
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    shakeKey.currentState?.deactivate();
    super.initState();
    widget.taskController.text = widget.taskModel.task;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.taskModel.dateTimeReminder);
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.height * 0.017,
          top: widget.height * 0.058,
          left: 25,
          right: 25),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topLeft,
            onTapClose: () {
              if (widget.taskController.text.isEmpty || widget.taskController.text.trim().isEmpty) {
                isTapped = true;
                shakeKey.currentState?.shake();
              } else {
                widget.onCloseTap();
              }
            },
            image: AppIcons.back,
          ),
          SizedBox(
            height: widget.height * 0.05,
          ),
          Flexible(
            child: ShakeWidget(
              key: shakeKey,
              shakeOffset: 10,
              shakeCount: 3,
              shakeDuration: const Duration(milliseconds: 500),
              child: TextField(
                onTap: () => setState(
                  () => isTapped = true,
                ),
                controller: widget.taskController,
                cursorColor: darkColor,
                cursorHeight: 26,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: widget.taskController.text.isEmpty
                      ? S.of(context).hintTaskText
                      : '',
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontSize: 26,
                    height: 2,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: darkColor,
                ),
                onChanged: (String newText) => setState(() {
                  widget.taskModel.task == newText;
                }),
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  isTapped = false;
                },
              ),
            ),
          ),
          SizedBox(
            height: widget.height * 0.03,
          ),
          Opacity(
            opacity: isTapped == true ? 0.2 : 1,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).color,
                    style: const TextStyle(
                      fontSize: 20,
                      color: greyTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.02,
                ),
                ColorsWidget(
                  width: widget.width,
                  selectedTaskColorIndex: widget.taskModel.colorIndex,
                ),
                SizedBox(
                  height: widget.height * 0.04,
                ),
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: separatorColor,
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).reminder,
                      style: const TextStyle(
                        fontSize: 20,
                        color: greyTextColor,
                      ),
                    ),
                    InkWell(
                      onTap: widget.onReminderTap,
                      child: Row(
                        children: [
                          const Text(
                            '+',
                            style: TextStyle(
                              fontSize: 24,
                              color: greyTextColor,
                            ),
                          ),
                          Text(
                            S.of(context).add,
                            style: const TextStyle(
                              fontSize: 18,
                              color: greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.height * 0.02,
                ),
                Slidable(
                  key: ValueKey(widget.taskModel.isReminderActive),
                  closeOnScroll: false,
                  endActionPane: ActionPane(
                    extentRatio: 0.35,
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        context.read<AppBloc>().add(
                              AppEventDeleteReminderFromTaskPage(
                                  taskModel: widget.taskModel,
                                  context: context),
                            );
                      },
                    ),
                    motion: const ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        onPressed: (BuildContext context) {
                          context.read<AppBloc>().add(
                                AppEventDeleteReminderFromTaskPage(
                                    taskModel: widget.taskModel,
                                    context: context),
                              );
                        },
                        child: Image.asset(
                          AppIcons.delete,
                        ),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: widget.onReminderTap,
                    child: (widget.taskModel.isReminderActive == true)
                        ? Row(
                            children: [
                              Text(
                                '${date.hour}-${date.minute.toString().padLeft(2, "0")}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${date.day} ${DateFormat("MMMM").format(date).toLowerCase().substring(0, 3)}.',
                                style: const TextStyle(
                                  color: paleTextColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.02,
                ),
                widget.isClosePanelTapped == false
                    ? Container(
                        decoration: BoxDecoration(
                          color: separatorColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: S.of(context).activeReminder,
                                        style: const TextStyle(
                                          color: activeReminderText,
                                          fontSize: 14,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            bottom: 4,
                                          ),
                                          child: Container(
                                            height: 6,
                                            width: 23,
                                            decoration: const BoxDecoration(
                                              color: textColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.width * 0.05,
                              ),
                              InkWell(
                                onTap: widget.onClosePanelTap,
                                child: Image.asset(
                                  AppIcons.closeButton,
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
