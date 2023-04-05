import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/lists_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/options_panel_widget.dart';

class ListsView extends StatefulWidget {
  final List<ListModel> listsList;
  final List<FocusNode> focusNodeList;
  final List<TextEditingController> controllerList;

  static const routeName = '/lists_page';

  const ListsView({
    Key? key,
    required this.listsList,
    required this.focusNodeList,
    required this.controllerList,
  }) : super(key: key);

  @override
  State<ListsView> createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListsPageBackgroundWidget(
        imageFile: _imageFile,
        height: heightScreen,
        width: widthScreen,
        lists: widget.listsList,
        focusNodeList: widget.focusNodeList,
        controllerList: widget.controllerList,
        onPressedClose: () {
          context.read<AppBloc>().add(
                AppEventGoToMainView(
                    listModel: widget.listsList[selectedListIndex]),
              );
        },
        onSettingsButtonTap: () {
          context.read<AppBloc>().add(
                const AppEventGoToSettings(),
              );
        },
        onListTap: (int selectedIndex) {
          context.read<AppBloc>().add(
                AppEventChangeList(
                  index: selectedIndex,
                  listModel: widget.listsList[selectedIndex],
                ),
              );
        },
        onAddButtonTap: () {
          context.read<AppBloc>().add(AppEventAddNewListPanelOpenFromListView(
              context: context,
              heightScreen: heightScreen,
              widthScreen: widthScreen,
              onBlackButtonPressed: (TextEditingController controller) {
                context.read<AppBloc>().add(
                  AppEventAddNewListFromListScreen(
                    listController: controller,
                  ),
                );
                Navigator.pop(context);
              }
          ));
        },
        onListRenameSubmitted: (String text, int selectedIndex) {
          context.read<AppBloc>().add(
                AppEventUpdateListText(
                  listModel: widget.listsList[selectedIndex],
                  listText: text,
                ),
              );
        },
        onOptionsTap: (int selectedIndex, BuildContext context) {
          context.read<AppBloc>().add(
            AppEventOptionsPanelOpen(
              context: context,
              selectedIndex: selectedIndex,
              heightScreen: heightScreen,
              widthScreen: widthScreen,
              onRenameTap: () {
                FocusScope.of(context)
                    .requestFocus(widget.focusNodeList[selectedIndex]);
                Navigator.pop(context);
              },
              onDeleteTap: () {
                Navigator.pop(context);
                context.read<AppBloc>().add(
                  AppEventDeleteList(
                    listModel: widget.listsList[selectedIndex],
                  ),
                );
              },
              changeListColor: (int index) {
                context.read<AppBloc>().add(
                  AppEventUpdateListColor(
                    listModel: widget.listsList[selectedIndex],
                    listColorIndex: index,
                  ),
                );
              },
              onThumbnailTap: () async {
                _showImagePickerDialog(context, selectedIndex);
            },
            ),
          );
        },
      ),
    );
  }
  Future<void> _showImagePickerDialog (BuildContext context, int selectedIndex) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Update list image?'),
          content: Image.file(File(pickedFile.path)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _imageFile = File(pickedFile.path);
                });
                await updateListImage(listID: widget.listsList[selectedIndex].listID, imageFile: _imageFile!);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
