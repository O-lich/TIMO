import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ListColorsWidget extends StatefulWidget {
  int selectedListColorIndex;
  final void Function(int index) changeListColor;
  final double width;

  ListColorsWidget({
    Key? key,
    required this.width,
    this.selectedListColorIndex = 0,
    required this.changeListColor,
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
        padding: EdgeInsets.zero,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: buttonColors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return ExpandTapWidget(
              tapPadding: const EdgeInsets.all(20.0),
              onTap: () {
                setState(() { //ToDo rewrite
                  (widget.selectedListColorIndex != index)
                      ? widget.selectedListColorIndex = index
                      : widget.selectedListColorIndex = 0;
                });
                widget.changeListColor(index);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: widget.width * 0.07,
                ),
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
        ),
      ),
    );
  }
}
