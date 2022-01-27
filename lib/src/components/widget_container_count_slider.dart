import 'package:flutter/material.dart';

import '../../export.dart';

class WidgetContainerCountSlider extends StatelessWidget {
  final num currentPos;
  final num index;

  const WidgetContainerCountSlider(
      {Key? key, required this.currentPos, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      width: currentPos == index ? 30 : 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          color:
              currentPos == index ? ColorConst.primaryColor : ColorConst.grey,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
