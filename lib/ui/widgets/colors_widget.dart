import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ColorsWidget extends StatefulWidget {
  int selectedTaskColorIndex;
  final double width;

  ColorsWidget({
    Key? key,
    required this.width,
    this.selectedTaskColorIndex = -1,
  }) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  double bottomPadding = 0;
  double topPadding = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(right: widget.width * 0.115),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: buttonColors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ExpandTapWidget(
                tapPadding: const EdgeInsets.symmetric(
                  vertical: 100,
                ),
                onTap: () {
                  setState(() {
                    if (widget.selectedTaskColorIndex != index) {
                      widget.selectedTaskColorIndex = index;
                    } else {
                      widget.selectedTaskColorIndex = -1;
                    }
                    taskCurrentColorIndex = widget.selectedTaskColorIndex;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.width * 0.035),
                  child: SingleColorWidget(
                    color: buttonColors[index],
                    bottomPadding: (widget.selectedTaskColorIndex == index)
                        ? bottomPadding = 20
                        : bottomPadding = 0,
                    topPadding: (widget.selectedTaskColorIndex == index)
                        ? topPadding = 0
                        : topPadding = 20,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
