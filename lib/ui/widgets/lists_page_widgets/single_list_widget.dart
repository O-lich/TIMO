import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
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
  }) : super(key: key);

  @override
  State<SingleListWidget> createState() => _SingleListWidgetState();
}

class _SingleListWidgetState extends State<SingleListWidget> {
  TextEditingController controller = TextEditingController();
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    shakeKey.currentState?.deactivate();
    super.initState();
    controller.text = widget.listModel.list;
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
                      tapPadding: const EdgeInsets.all(50.0),
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
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      autofocus: false,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        color: darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      controller: controller,
                      cursorColor: darkColor,
                      cursorHeight: 18,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      onTapOutside: (_) {
                        if (controller.text.isEmpty) {
                          widget.focusNode.hasFocus;
                          shakeKey.currentState?.shake();
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      // onChanged: (text) {
                      //   if (controller.text.isNotEmpty) {
                      //
                      //     }
                      // },
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
