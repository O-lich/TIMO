import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/style.dart';

class LoadingView extends StatefulWidget {
  final ListModel listModel;

  const LoadingView({
    Key? key,
    required this.listModel,
  }) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return ClipRect(
      child: FadeTransition(
        opacity: _animationController,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: widthScreen,
              height: heightScreen * 0.42,
              decoration: BoxDecoration(
                  color: buttonColors[widget.listModel.listColorIndex]),
            ),
            Positioned(
              top: heightScreen * 0.42,
              child: Container(
                width: widthScreen,
                height: heightScreen * 0.58,
                decoration: const BoxDecoration(
                    borderRadius: commonBorderRadius,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
