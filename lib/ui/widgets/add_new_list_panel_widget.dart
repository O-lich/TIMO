import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/shake_error_widget.dart';
import 'black_button_widget.dart';

class AddNewListPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;
  final void Function(TextEditingController controller) onBlackButtonTap;

  const AddNewListPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onTapClose,
    required this.onBlackButtonTap,
  }) : super(key: key);

  @override
  State<AddNewListPanelWidget> createState() => _AddNewListPanelWidgetState();
}

class _AddNewListPanelWidgetState extends State<AddNewListPanelWidget> {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  late final focusNode;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topRight,
            onTapClose: widget.onTapClose,
            image: AppIcons.closeButton,
          ),
          ShakeWidget(
            key: shakeKey,
            shakeOffset: 10,
            shakeCount: 3,
            shakeDuration: const Duration(milliseconds: 700),
            child: TextField(
              focusNode: focusNode,
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              style: TextStyle(
                fontSize: 0.018 * widget.height,
              ),
              decoration: InputDecoration(
                hintText: S.of(context).newList,
                hintStyle: TextStyle(
                  color: hintTextColor,
                  fontSize: 0.018 * widget.height,
                ),
                border: InputBorder.none,
              ),
              scrollPadding: const EdgeInsets.all(20.0),
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              cursorColor: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: keyBoardHeight > 0 ? keyBoardHeight + 10 : 10),
            child: Column(
              children: [
                BlackButtonWidget(
                  height: widget.height * 0.05,
                  onPressed: () {
                    if (controller.text.isNotEmpty && controller.text.trim().isNotEmpty) {
                      widget.onBlackButtonTap(controller);
                    } else {
                      FocusScope.of(context).requestFocus(focusNode);
                      shakeKey.currentState?.shake();
                    }
                  },
                  width: widget.width - 50,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(12, 12)),
                  child: Text(
                    S.of(context).createNewList,
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
