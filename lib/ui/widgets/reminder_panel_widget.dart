import 'package:flutter/cupertino.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

class ReminderPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onCloseTap;
  final void Function() onSaveTap;
  final TaskModel taskModel;

  const ReminderPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onCloseTap,
    required this.onSaveTap,
    required this.taskModel,
  }) : super(key: key);

  @override
  State<ReminderPanelWidget> createState() => _ReminderPanelWidgetState();
}

class _ReminderPanelWidgetState extends State<ReminderPanelWidget> {
  DateTime? _chosenDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelCloseWidget(
              alignment: Alignment.topRight,
              onTapClose: widget.onCloseTap,
              image: AppIcons.closeButton,
            ),
            Text(
              TestStrings.reminder,
              style: TextStyle(
                fontSize: 0.03 * widget.height,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 0.05 * widget.height,
                top: 0.03 * widget.height,
              ),
              child: SizedBox(
                height: 0.27 * widget.height,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 0.04 * widget.height,
              ),
              child: BlackButtonWidget(
                onPressed: () {
                  _updateTaskReminder(
                    oldTask: widget.taskModel,
                    dateTimeReminder: _chosenDateTime.toString(),
                    isReminderActive: true,
                  );
                  widget.onSaveTap;
                  Navigator.pop(context);
                },
                width: widget.width - 50,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                height: widget.height * 0.07,
                child: const Text(
                  TestStrings.saveReminderButton,
                  style: TextStyle(color: backgroundColor, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTaskReminder({
    required TaskModel oldTask,
    required dateTimeReminder,
    required isReminderActive,
  }) async {
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .doc(oldTask.listID)
        .collection('tasks')
        .doc(oldTask.taskID);

    final updates = <String, dynamic>{
      "dateTimeReminder": dateTimeReminder,
      "isReminderActive": isReminderActive,
    };
    docRef.update(updates);
  }
}
