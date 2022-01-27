import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';

import '../../export.dart';
import 'camera_search_page.dart';

class UserManualCameraPage extends StatelessWidget {
  Function? callBack;
  UserManualCameraPage({Key? key,this.callBack}) : super(key: key);

  late BuildContext contextMain;

  // double width=

  @override
  Widget build(BuildContext context) {
    contextMain = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(
            title: "Hướng dẫn sử dụng",
            turnOffSearch: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [

                  widgetItem("1. Chụp hoặc tải lên hình ảnh kích cỡ đầy đủ cây trồng", [
                    "assets/temp/image_temple3.png",
                    "assets/temp/image_temple4.png",
                  ]),
                  SizedBox(
                    height: 25,
                  ),
                  widgetItem(
                      "2. Chụp hoặc tải lên hình ảnh cận cảnh sinh vật gây hại trên cây trồng.",
                      [
                        "assets/temp/image_temple5.png",
                        "assets/temp/image_temple6.png",
                      ]),
                  SizedBox(
                    height: 25,
                  ),
                  widgetItem("3. Đảm bảo ảnh chụp hoặc tải lên rõ nét, không bị mờ", [
                    "assets/temp/image_temple7.png",
                    "assets/temp/image_temple8.png",
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 64, right: 64),
                    child: WidgetButton(
                      text: "Bắt đầu",
                      textColor: Colors.white,
                      radius: 100,
                      onTap: (){
                        callBack?.call();
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget widgetItem(String title, List<String> listImage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: StyleConst.regularStyle(),
          ),
          Row(
            children: [
              widgetItemImage(0, listImage[0]),
              SizedBox(
                width: 33,
              ),
              widgetItemImage(1, listImage[1]),
            ],
          )
        ],
      ),
    );
  }

  Widget widgetItemImage(int index, String imageAssets) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 15,
              top: 16,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageAssets,
                width: 1000,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: index == 0
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageIcon(
                      AssetImage(AssetsConst.iconDelete),
                      size: 30,
                      color: ColorConst.primaryColor,
                    ),
                  )
                : Image.asset(
                    AssetsConst.iconCheck,
                    width: 30,
                    height: 30,
                  ),
          )
        ],
      ),
    );
  }
}
