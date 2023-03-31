import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/shake_error_widget.dart';

class SingleListWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onOptionsTap;
  final void Function() onListTap;
  final void Function() onAddButtonTap;
  final bool isTapped;
  final FocusNode focusNode;
  ListModel listModel;
  final TextEditingController controller;

  SingleListWidget({
    Key? key,
    required this.height,
    required this.onOptionsTap,
    required this.listModel,
    required this.isTapped,
    required this.onListTap,
    required this.onAddButtonTap,
    required this.width,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  State<SingleListWidget> createState() => _SingleListWidgetState();
}

class _SingleListWidgetState extends State<SingleListWidget> {
  //TextEditingController controller = TextEditingController();
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    shakeKey.currentState?.deactivate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onListTap,
      child: ShakeWidget(
        key: shakeKey,
        shakeOffset: 10,
        shakeCount: 3,
        shakeDuration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Container(
              height: widget.height * 0.20,
              decoration: BoxDecoration(
                color: buttonColors[widget.listModel.listColorIndex],
                borderRadius: BorderRadius.circular(26),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 10,
                    child: ExpandTapWidget(
                      tapPadding: const EdgeInsets.all(30.0),
                      onTap: widget.onOptionsTap,
                      child: Image.asset(
                        AppIcons.options,
                        scale: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 33,
              child: Row(
                children: [
                  Image.asset(
                    AppIcons.userPoint,
                    scale: 3,
                    color: widget.isTapped ? Colors.black : Colors.transparent,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextField(
                      focusNode: widget.focusNode,
                      autofocus: false,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        color: darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      controller: widget.controller,
                      cursorColor: darkColor,
                      cursorHeight: 18,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      onTapOutside: (_) {
                        if (widget.controller.text.isEmpty) {
                          widget.focusNode.hasFocus;
                          shakeKey.currentState?.shake();
                        } else {
                          widget.controller.text = widget.listModel.list;
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      onSubmitted: (text) { //ToDo
                        if (widget.controller.text.isEmpty) {
                          widget.focusNode.hasFocus;
                          shakeKey.currentState?.shake();
                        } else {
                          context.read<AppBloc>().add(
                                AppEventUpdateListText(
                                  listModel: widget.listModel,
                                  listText: text,
                                ),
                              );
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
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
