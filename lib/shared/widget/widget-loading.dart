import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../export.dart';


class WidgetLoading extends StatelessWidget {
  final bool notData;
  final String? title;
  final String? titleNotData;

  const WidgetLoading({Key? key, this.notData = false, this.title,this.titleNotData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final spinKit = SpinKitCircle(
      color: ColorConst.primaryColor,
      size: 30.0,
    );

    return Center(
      child: notData
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titleNotData?? "Không còn dữ liệu để hiển thị.",
                style: StyleConst.mediumStyle(fontStyle: FontStyle.italic),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: spinKit,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? "Đang tải...",
                  style: StyleConst.regularStyle(),
                ),
              ],
            ),
    );
  }
}
