import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/notification/notification_page.dart';
import 'package:viettel_app/src/seach/search_page.dart';

import '../../../export.dart';

class WidgetAppbar extends StatelessWidget {
  final String title;
  final bool turnOffButtonBack;
  final bool turnOffNotification;
  final bool turnOffSearch;
  final Widget? widgetIcons;
  final Widget? widgetIconStart;
  final Function? callBack;

  const WidgetAppbar(
      {Key? key,
      required this.title,
      this.widgetIcons,
      this.widgetIconStart,
      this.callBack,
      this.turnOffButtonBack = false,
      this.turnOffNotification = false,
      this.turnOffSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthTemple = 0.0;
    double widthTemple2 = 40.0;
    if (!turnOffNotification) {
      widthTemple += 20;
    } else {
      widthTemple2 -= 20;
    }
    if (!turnOffSearch) {
      widthTemple += 20;
    } else {
      widthTemple2 -= 20;
    }
    return Container(
      margin:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 2),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: ColorConst.grey.withOpacity(.2),
            blurRadius: 10.0,
            offset: Offset(0.0, 5.0)),
      ], color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          turnOffButtonBack == false
              ? GestureDetector(
                  onTap: () {
                    if (callBack == null)
                      Get.back();
                    else {
                      callBack?.call();
                    }
                    // Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(right: widthTemple2),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                )
              : SizedBox(
                  width: widthTemple,
                ),
          widgetIconStart??SizedBox(),

          Expanded(
            child: Text(
              "$title",
              style: StyleConst.boldStyle(
                  fontSize: titleSize, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: !turnOffSearch,
            child: GestureDetector(
              onTap: () {
                Get.to(SearchPage());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Image(
                  image: AssetImage(
                    AssetsConst.iconSearch,
                  ),
                  width: 20,
                ),
              ),
            ),
          ),
          Visibility(
            // visible: !turnOffNotification,
            visible: Get.find<AuthController>().isLogged(),
            child: GestureDetector(
              onTap: () {
                Get.to(NotificationPage());
              },
              child: Image(
                image: AssetImage(
                  AssetsConst.iconNotification,
                ),
                width: 20,
              ),
            ),
          ),
          widgetIcons ?? SizedBox()
        ],
      ),
    );
  }
}
