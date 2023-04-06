import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/strings.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          AssetsImagesStrings.splashViewImage
        ),
      ),
    );
  }
}
