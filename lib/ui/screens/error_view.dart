import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: widthScreen,
            height: heightScreen * 0.42,
            decoration: BoxDecoration(color: buttonColors[0]),
          ),
          Positioned(
            top: heightScreen * 0.42,
            child: Container(
              width: widthScreen,
              height: heightScreen * 0.58,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(21),
                    topLeft: Radius.circular(21),
                  ),
                  color: Colors.white),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppEventGetUser(),
                          );
                    },
                    child: Text(
                      S.of(context).error,
                      style: const TextStyle(
                          fontSize: 46,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
