import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/style.dart';

import 'add_new_list_panel_widget.dart';
import 'lists_page_widgets/options_panel_widget.dart';
import 'lists_panel_widget.dart';
import 'new_task_page_widgets/colors_panel_widget.dart';

class CustomModalBottomSheet {
  static void showModalAddNewListPanelWidget({
    required BuildContext context,
    required double heightScreen,
    required double widthScreen,
    required void Function(TextEditingController controller)
        onBlackButtonPressed,
  }) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: AddNewListPanelWidget(
          height: heightScreen,
          onTapClose: () {
            Navigator.of(context).pop();
          },
          width: widthScreen,
          onBlackButtonTap: (controller) {
            onBlackButtonPressed(controller);
          },
        ),
      ),
    );
  }

  static void showModalOptionsPanelWidget({
    required BuildContext context,
    required double heightScreen,
    required double widthScreen,
    required void Function() onRenameTap,
    required void Function() onDeleteTap,
    required void Function() onThumbnailTap,
    required void Function(int index) changeListColor,
    required List<ListModel> listsList,
    required int selectedIndex,
  }) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: OptionsPanelWidget(
          selectedListColorIndex: listsList[selectedIndex].listColorIndex,
          height: heightScreen,
          width: widthScreen,
          onTapClose: () {
            Navigator.pop(context);
          },
          onRenameTap: () {
            onRenameTap();
          },
          onDeleteTap: () {
            onDeleteTap();
          },
          changeListColor: (int index) {
            changeListColor(index);
          },
          onThumbnailTap: () {
            onThumbnailTap();
          },
        ),
      ),
    );
  }

  static void showModalColorsPanelWidget({
    required BuildContext context,
    required double heightScreen,
    required double widthScreen,
    required List<ListModel> listsList,
    required int selectedIndex,
    required void Function() onAddNewListPressed,
  }) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: ColorsPanelWidget(
          selectedTaskColorIndex: selectedIndex,
          height: heightScreen,
          width: widthScreen,
          onTapClose: Navigator.of(context).pop,
          lists: listsList,
          colorsList: buttonColors,
          onAddNewListPressed: () {
            onAddNewListPressed();
          },
        ),
      ),
    );
  }

  static void showModalListsPanelWidgetFromMainView({
    required BuildContext context,
    required double heightScreen,
    required double widthScreen,
    required List<ListModel> listsList,
    required void Function() onMoveToButtonPressed,
    required void Function() onAddNewList,
  }) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: ListsPanelWidget(
          onButtonPressed: () {
            onMoveToButtonPressed();
            Navigator.pop(context);
          },
          height: heightScreen,
          width: widthScreen,
          lists: listsList,
          onTapClose: Navigator.of(context).pop,
          onAddNewListPressed: () {
            onAddNewList();
          },
        ),
      ),
    );
  }

  static void showModalListsPanelWidgetFromTaskView({
    required BuildContext context,
    required double heightScreen,
    required double widthScreen,
    required List<ListModel> listsList,
    required void Function() onAddNewList,
  }) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: ListsPanelWidget(
          onButtonPressed: Navigator.of(context).pop,
          height: heightScreen,
          width: widthScreen,
          lists: listsList,
          onTapClose: Navigator.of(context).pop,
          onAddNewListPressed: () {
            onAddNewList();
          },
        ),
      ),
    );
  }
}
