import 'package:flutter/material.dart';

import '../../../export.dart';

class WidgetItemEvent extends StatelessWidget {
  Function? onTap;
  final String title;

  WidgetItemEvent(this.title,{Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: ColorConst.backgroundColor, width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$title",
                style: StyleConst.regularStyle(fontSize: titleSize),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: ColorConst.grey,
            )
          ],
        ),
      ),
    );
  }
}
