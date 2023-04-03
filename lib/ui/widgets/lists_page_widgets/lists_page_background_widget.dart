import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/single_list_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';
import 'add_button_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressedClose;
  final List<ListModel> lists;
  final void Function() onAddButtonTap;
  final void Function() onSettingsButtonTap;
  final List<FocusNode> focusNodeList;
  final List<TextEditingController> controllerList;
  final void Function(String text, int selectedIndex) onListRenameSubmitted;
  final void Function(int selectedIndex) onListTap;
  final void Function(int selectedIndex, BuildContext context) onOptionsTap;

  const ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressedClose,
    required this.lists,
    required this.onAddButtonTap,
    required this.onSettingsButtonTap,
    required this.focusNodeList,
    required this.controllerList,
    required this.onListRenameSubmitted,
    required this.onListTap,
    required this.onOptionsTap,
  }) : super(key: key);

  @override
  State<ListsPageBackgroundWidget> createState() =>
      _ListsPageBackgroundWidgetState();
}

class _ListsPageBackgroundWidgetState extends State<ListsPageBackgroundWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: widget.height * 0.017,
          top: widget.height * 0.048,
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpandTapWidget(
                  tapPadding: const EdgeInsets.all(50.0),
                  onTap: widget.onSettingsButtonTap,
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
                NavBarWidget(
                  height: widget.height,
                  onPressed: widget.onPressedClose,
                  width: widget.width,
                  titleColor: backgroundColor,
                  buttonColor: darkColor,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: (widget.width * 0.04),
              ),
              child: widget.lists.isEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04),
                        child: AddButtonWidget(
                          onAddButtonTap: () {
                            widget.onAddButtonTap();
                          },
                          width: widget.width,
                          height: widget.height,
                        ),
                      ),
                    )
                  : GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1.5 / 2.5,
                      crossAxisSpacing: widget.width * 0.1,
                      mainAxisSpacing: widget.width * 0.01,
                      children: [
                        ...widget.lists.asMap().entries.map(
                              (list) => SingleListWidget(
                                onListTap: () {
                                  widget.onListTap(list.key);
                                },
                                height: widget.height,
                                onOptionsTap: () {
                                  widget.onOptionsTap(list.key, context);
                                },
                                listModel: list.value,
                                isTapped: selectedListIndex == list.key,
                                onAddButtonTap: () {
                                  widget.onAddButtonTap();
                                },
                                width: widget.width,
                                focusNode: widget.focusNodeList[list.key],
                                controller: widget.controllerList[list.key],
                                onListRenameSubmitted: (String text) {
                                  widget.onListRenameSubmitted(text, list.key);
                                },
                              ),
                            ),
                        AddButtonWidget(
                          onAddButtonTap: () {
                            widget.onAddButtonTap();
                          },
                          width: widget.width,
                          height: widget.height,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
