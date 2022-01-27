import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/home/nagivator_bottom_page.dart';

import '../../export.dart';

class FlashScreenSuccessPage extends StatelessWidget {
  const FlashScreenSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 68,
            ),
            Image.asset(
              AssetsConst.logoFlashScreen,
              width: 126,
              height: 126,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       AssetsConst.logo,
            //       width: 184,
            //       height: 63,
            //     ),
            //     SizedBox(
            //       width: 16,
            //     ),
            //     Image.asset(
            //       AssetsConst.logoFlashScreen,
            //       width: 63,
            //       height: 63,
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 166, bottom: 14),
              child: Text(
                "Cảm ơn bạn đã cung cấp thông tin",
                style: StyleConst.mediumStyle(fontSize: titleSize, height: 1.2),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, bottom: 33),
              child: Text(
                "Vui lòng nhấn nút hoàn thành\nđể bắt đầu sử dụng ứng dụng.",
                style: StyleConst.regularStyle(height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: WidgetButton(
                text: "Hoàn thành",
                textColor: Colors.white,
                onTap: (){
                  Get.offAll(NavigatorBottomPage());
                },
                radius: 100,
              ),
            ),
            SizedBox(
              height: 34+MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
