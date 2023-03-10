import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/date_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/quote_widget.dart';

class MainScreenBackgroundWidget extends StatelessWidget {
  final double? height;
  final void Function() onPressed;

  const MainScreenBackgroundWidget({
    super.key,
    this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.049 * height!,
              ),
              NavBarWidget(
                height: height!,
                onPressed: onPressed,
              ),
              DateWidget(
                dateTime: DateTime.now(),
                height: height,
              ),
              SizedBox(
                height: 0.044 * height!,
              ),
              QuoteWidget(
                author: TestStrings.quoteAuthor,
                content: TestStrings.quoteContent,
                height: height,
              ),
              SizedBox(
                height: 0.03 * height!,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
