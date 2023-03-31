import 'package:flutter/material.dart';

class SingleColorWidget extends StatelessWidget {
  final Color color;
  final double bottomPadding;
  final double topPadding;

  const SingleColorWidget({
    Key? key,
    required this.color,
    required this.bottomPadding,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 56,
      width: 10,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          top: topPadding,
        ),
        child: Container(
          height: 36,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
