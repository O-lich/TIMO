import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class AlarmNotifWidget extends StatefulWidget {
  final String content;

  const AlarmNotifWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  State<AlarmNotifWidget> createState() => _AlarmNotifWidgetState();
}

class _AlarmNotifWidgetState extends State<AlarmNotifWidget> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      height: heightScreen * 0.07,
      width: widthScreen * 0.9,
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
                widget.content,
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
