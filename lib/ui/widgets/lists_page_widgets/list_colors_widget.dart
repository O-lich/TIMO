import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ListColorsWidget extends StatefulWidget {
  int selectedListColorIndex;
  final double width;

  ListColorsWidget({
    Key? key,
    required this.width,
    this.selectedListColorIndex = 0,
  }) : super(key: key);

  @override
  State<ListColorsWidget> createState() => _ListColorsWidgetState();
}

class _ListColorsWidgetState extends State<ListColorsWidget> {
  double bottomPadding = 0;
  double topPadding = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.115),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: buttonColors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return ExpandTapWidget(
              tapPadding: const EdgeInsets.all(20.0),
              onTap: () {
                setState(() {
                  (widget.selectedListColorIndex != index) ?
                  widget.selectedListColorIndex = index : widget.selectedListColorIndex = 0;
                  listCurrentColorIndex = widget.selectedListColorIndex;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.width * 0.035),
                child: SingleColorWidget(
                  color: buttonColors[index],
                  bottomPadding: (widget.selectedListColorIndex == index)
                      ? bottomPadding = 20
                      : bottomPadding = 0,
                  topPadding: (widget.selectedListColorIndex == index)
                      ? topPadding = 0
                      : topPadding = 20,
                ),
              ),
            );
          },
          // separatorBuilder: (BuildContext context, int index) => SizedBox(
          //   width: widget.width * 0.07,
          // ),
        ),
      ),
    );
  }


}
