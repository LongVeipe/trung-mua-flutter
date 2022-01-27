import 'package:flutter/material.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';

class WidgetIconText extends StatelessWidget {
  final String? iconAsset;
  final Widget? icon;
  final String text;
  final double? size;
  final TextStyle? style;
  final Color? colorIcon;

  const WidgetIconText(
      {Key? key,  this.iconAsset,this.icon, required this.text, this.style,this.size,this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconAsset!=null?
        Image(
          image: AssetImage(iconAsset??""),
          width: size??16,
          height: size??16,
          color: colorIcon,
        ):icon??SizedBox.shrink(),
        SizedBox(width: 5,),
        Expanded(
          child: Text(
            text,
            style: style,
          ),
        )
      ],
    );
  }
}
