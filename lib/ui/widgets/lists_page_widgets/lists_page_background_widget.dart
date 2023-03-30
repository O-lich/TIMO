import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/options_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/single_list_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';
import 'add_button_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final List<ListModel> lists;
  final void Function() onAddButtonTap;
  final void Function() onSettingsButtonTap;
  final List <FocusNode> focusNodeList;
  final List <TextEditingController> controllerList;

  const ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.lists,
    required this.onAddButtonTap,
    required this.onSettingsButtonTap,
    required this.focusNodeList, required this.controllerList,
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
  void dispose() {
    for (int i = 0; i < widget.lists.length; i++) {
      widget.focusNodeList[i].dispose();
    }
    super.dispose();
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
                  onPressed: widget.onPressed,
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
                                  context.read<AppBloc>().add(
                                        AppEventChangeList(index: list.key),
                                      );
                                },
                                height: widget.height,
                                onOptionsTap: () {
                                  _selectedIndex = list.key;
                                  SlidingPanelHelper().onPressedShowBottomSheet(
                                    OptionsPanelWidget(
                                      selectedListColorIndex: widget
                                          .lists[_selectedIndex].listColorIndex,
                                      height: widget.height,
                                      width: widget.width,
                                      onTapClose: () {
                                        context.read<AppBloc>().add(
                                              AppEventUpdateListColor(
                                                listModel: widget
                                                    .lists[_selectedIndex],
                                                listColorIndex:
                                                    listCurrentColorIndex,
                                              ),
                                            );
                                        Navigator.pop(context);
                                      },
                                      colors: buttonColors,
                                      onRenameTap: () {
                                        FocusScope.of(context).requestFocus(
                                            widget.focusNodeList[list.key]);
                                        Navigator.pop(context);
                                      },
                                      onDeleteTap: () {
                                        Navigator.pop(context);
                                        context.read<AppBloc>().add(
                                              AppEventDeleteList(
                                                listModel: widget
                                                    .lists[_selectedIndex],
                                              ),
                                            );
                                      },
                                    ),
                                    context,
                                  );
                                },
                                listModel: list.value,
                                isTapped: selectedListIndex == list.key,
                                onAddButtonTap: () {
                                  widget.onAddButtonTap();
                                },
                                width: widget.width,
                                focusNode: widget.focusNodeList[list.key],
                                controller: widget.controllerList[list.key],//ToDo for add new list
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
