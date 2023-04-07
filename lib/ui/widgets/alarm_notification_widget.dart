import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class AlarmNotifWidget extends StatelessWidget {
  final String content;
  final double? height;
  final double? width;

  const AlarmNotifWidget({
    Key? key,
    required this.content,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height! * 0.07,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  color: paleTextColor,
                  fontSize: 17,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                AppIcons.closeButtonDarker,
                scale: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
