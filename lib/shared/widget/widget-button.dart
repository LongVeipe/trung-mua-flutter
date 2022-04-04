import 'package:flutter/material.dart';
import '../../export.dart';


class WidgetButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? radiusColor;
  final double? radius;
  bool isEnable;

  // final double? height;
  final double? paddingBtnWidth;
  final double? paddingBtnHeight;

  WidgetButton({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.radius,
    this.isEnable = true,
    // this.height,
    this.paddingBtnWidth,
    this.paddingBtnHeight,
    this.radiusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.isEnable? () => onTap?.call() : null,
      child: Container(
        // height: height ?? 40,
        padding: EdgeInsets.symmetric(
            vertical: paddingBtnHeight ?? 15,
            horizontal: paddingBtnWidth ?? 15),
        decoration: BoxDecoration(
            // border: Border.all(color: radiusColor ?? ColorConst.primaryColor),
            border: Border.all(color: radiusColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            color: backgroundColor ?? ColorConst.primaryColor,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                backgroundColor ?? ColorConst.primaryColor,
                backgroundColor ?? ColorConst.primaryColor,
              ],
            )),

        child: Center(
          child: Text(
            text,
            style: StyleConst.boldStyle(color: textColor ?? ColorConst.textPrimary),
            // style: StyleConst.boldStyle(color:  ColorConst.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
