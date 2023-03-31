import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/strings.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      width: widthScreen,
      height: heightScreen,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsImagesStrings.quoteBackgroundBlur),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
