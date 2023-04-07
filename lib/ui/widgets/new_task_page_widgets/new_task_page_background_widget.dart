import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/shake_error_widget.dart';
import '../black_button_widget.dart';

class NewTaskPageBackgroundWidget extends StatefulWidget {
  final TextEditingController taskController;
  final double height;
  final double width;
  final void Function() onBlackButtonPressed;
  final void Function() onReminderTap;
  final void Function() onListsTap;
  final void Function() onCloseTap;
  final bool isReminderActive;

  const NewTaskPageBackgroundWidget({
    Key? key,
    required this.taskController,
    required this.height,
    required this.width,
    required this.onBlackButtonPressed,
    required this.onReminderTap,
    required this.onListsTap,
    required this.onCloseTap,
    required this.isReminderActive,
  }) : super(key: key);

  @override
  State<NewTaskPageBackgroundWidget> createState() =>
      _NewTaskPageBackgroundWidgetState();
}

class _NewTaskPageBackgroundWidgetState
    extends State<NewTaskPageBackgroundWidget> {
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.height * 0.017,
          top: widget.height * 0.048,
          left: 25,
          right: 25),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topRight,
            onTapClose: widget.onCloseTap,
            image: AppIcons.close,
          ),
          Expanded(
            child: ShakeWidget(
              key: shakeKey,
              shakeOffset: 10,
              shakeCount: 3,
              shakeDuration: const Duration(milliseconds: 500),
              child: TextField(
                enableInteractiveSelection: true,
                textCapitalization: TextCapitalization.sentences,
                controller: widget.taskController,
                style: const TextStyle(
                  fontSize: 26,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).hintText,
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontSize: 26,
                    height: 2,
                  ),
                  border: InputBorder.none,
                ),
                scrollPadding: const EdgeInsets.all(20.0),
                autofocus: true,
                keyboardType: TextInputType.text,
                maxLines: 10,
                cursorColor: Colors.black,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onSubmitted: (_) {
                  if (widget.taskController.text.isEmpty || widget.taskController.text.trim().isEmpty) {
                    widget.taskController.text = '';
                    shakeKey.currentState?.shake();
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * widget.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: widget.onListsTap,
                      child: Image.asset(
                        AppIcons.lists,
                        scale: 3,
                      ),
                    ),
                    SizedBox(
                      width: widget.width * 0.05,
                    ),
                    InkWell(
                      onTap: widget.onReminderTap,
                      child: Image.asset(
                        widget.isReminderActive
                            ? AppIcons.reminderBellActive
                            : AppIcons.reminderBell,
                        scale: 3,
                      ),
                    ),
                  ],
                ),
                BlackButtonWidget(
                  height: widget.height * 0.05,
                  onPressed: () {
                    if (widget.taskController.text.isEmpty || widget.taskController.text.trim().isEmpty) {
                      widget.taskController.text = '';
                      shakeKey.currentState?.shake();
                    } else {
                      widget.onBlackButtonPressed();
                    }
                  },
                  width: widget.width * 0.3,
                  borderRadius: BorderRadius.circular(22),
                  child: Text(
                    S.of(context).create,
                    style: const TextStyle(color: backgroundColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
