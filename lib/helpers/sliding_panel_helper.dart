import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/add_new_list_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/colors_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/reminder_panel_widget.dart';

class SlidingPanelHelper {
  void onPressedShowBottomSheet(Widget child, BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: child,
      ),
    );
  }

  void onAddNewListPressed({
    required double widthScreen,
    required double heightScreen,
    required BuildContext context,
    required void Function(TextEditingController controller) onBlackButtonTap,
  }) {
    onPressedShowBottomSheet(
        AddNewListPanelWidget(
          height: heightScreen,
          onTapClose: () {
            Navigator.of(context).pop();
          },
          width: widthScreen,
          onBlackButtonTap: (controller) {
            onBlackButtonTap(controller);
          },
        ),
        context);
  }

  void onReminderTap(
    double widthScreen,
    double heightScreen,
    BuildContext context,
    void Function(DateTime? dateTime) onSaveTap,
    TaskModel taskModel,
  ) {
    onPressedShowBottomSheet(
        ReminderPanelWidget(
          taskModel: taskModel,
          height: heightScreen,
          onCloseTap: () {
            Navigator.of(context).pop();
          },
          width: widthScreen,
          onSaveTap: (dateTime) {
            onSaveTap(dateTime);
          },
        ),
        context);
  }

  void onListsTap(
      BuildContext context,
      double widthScreen,
      double heightScreen,
      List<ListModel> lists,
      List<Color> buttonColors,
      TextEditingController controller,
      int selectedIndex) {
    SlidingPanelHelper().onPressedShowBottomSheet(
      ColorsPanelWidget(
        selectedTaskColorIndex: selectedIndex,
        height: heightScreen,
        width: widthScreen,
        onTapClose: Navigator.of(context).pop,
        lists: lists,
        colorsList: buttonColors,
        onAddNewListPressed: () {
          SlidingPanelHelper().onAddNewListPressed(
            widthScreen: widthScreen,
            heightScreen: heightScreen,
            context: context,
            onBlackButtonTap: (listController) {},
          );
        },
      ),
      context,
    );
  }

// void onOptionsTap(BuildContext context, double widthScreen,
//     double heightScreen, List<Color> buttonColors, void Function() onRenameTap) {
//   SlidingPanelHelper().onPressedShowBottomSheet(
//     OptionsPanelWidget(
//       height: heightScreen,
//       width: widthScreen,
//       onTapClose: Navigator.of(context).pop,
//       colors: buttonColors,
//       onRenameTap: onRenameTap,),
//     context,
//   );
// }
}
