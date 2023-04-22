import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class NavBarWidget extends StatelessWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final Color titleColor;
  final Color buttonColor;
  final String buttonTitle;

  const NavBarWidget({
    Key? key,
    required this.height,
    required this.onPressed,
    required this.width,
    required this.titleColor,
    required this.buttonColor,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ExpandTapWidget(
        onTap: onPressed,
        tapPadding: const EdgeInsets.all(60.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 0.01 * height,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(
                color: darkColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.004 * height,
                horizontal: 0.033 * width,
              ),
              child: Text(
                buttonTitle,
                style: TextStyle(color: titleColor, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
