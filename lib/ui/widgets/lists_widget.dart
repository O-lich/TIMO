import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';

class ListsWidget extends StatefulWidget {
  final double height;
  final List<ListModel> lists;
  final void Function() onAddNewListPressed;

  const ListsWidget({
    Key? key,
    required this.height,
    required this.lists,
    required this.onAddNewListPressed,
  }) : super(key: key);

  @override
  State<ListsWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsWidget> {
  int selectedIndex = selectedListIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height * 0.01,
        ),
        Text(
          S.of(context).chooseLists,
          style: TextStyle(
            fontSize: 0.03 * widget.height,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.01 * widget.height),
          child: SizedBox(
            height: 0.05 * widget.height,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.lists.length,
                itemBuilder: (context, index) {
                  if (widget.lists[index].list.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          moveToListIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.lists[index].list,
                                style: const TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.check,
                              scale: 3,
                              color: selectedIndex == index
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return null;
                }),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 0.03 * widget.height,
          ),
          child: ExpandTapWidget(
            tapPadding: const EdgeInsets.all(20.0),
            onTap: widget.onAddNewListPressed,
            child: Text(
              S.of(context).addNewList,
              style: TextStyle(
                fontSize: 0.018 * widget.height,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}