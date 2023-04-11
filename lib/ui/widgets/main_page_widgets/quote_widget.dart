import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';

class QuoteWidget extends StatefulWidget {
  final QuoteModel quoteModel;
  final double? height;

  const QuoteWidget({
    super.key,
    required this.height,
    required this.quoteModel,
  });

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDialog,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.quoteModel.author,
            style: const TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 0.008 * widget.height!,
          ),
          Text(
            widget.quoteModel.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future _showDialog() => showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        double widthScreen = MediaQuery.of(context).size.width;
        double heightScreen = MediaQuery.of(context).size.height;
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: widthScreen,
              height: heightScreen,
              color: Colors.white.withOpacity(0.85),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0.067 * heightScreen,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          AppIcons.close,
                          scale: 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.quoteModel.author,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CeraPro',
                          ),
                        ),
                        SizedBox(
                          height: heightScreen * 0.03,
                        ),
                        Text(
                          widget.quoteModel.content,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CeraPro',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
