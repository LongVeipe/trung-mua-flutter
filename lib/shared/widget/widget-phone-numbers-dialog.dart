import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/export.dart';

class PhoneNumbersDialog extends StatelessWidget {
  final String phoneNumbers;

  const PhoneNumbersDialog({Key? key, required this.phoneNumbers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: phoneNumbers));
                Get.back();
                // showSnackBar(title: "", body: "Đã sao chép", duration: 1);
                showBottomSnackbar(context: context, content: "Đã sao chép");
              },
              style: TextButton.styleFrom(primary: ColorConst.primaryColor),
              child: Text(
                "Sao chép",
                style: StyleConst.regularStyle(),
              )),
          TextButton(
              onPressed: () async {
                final String uri = "tel://$phoneNumbers";
                if (await canLaunch(uri)) {
                  await launch(uri);
                } else {
                  showSnackBar(
                      title: "Thông báo", body: "Không thể mở cuộc gọi");
                  throw 'Could not launch $uri';
                }
              },
              style: TextButton.styleFrom(primary: ColorConst.primaryColor),
              child: Text(
                "Gọi điện",
                style: StyleConst.regularStyle(),
              )),
          TextButton(
              onPressed: () async {
                final String uri = 'sms:$phoneNumbers';
                if (await canLaunch(uri)) {
                  await launch(uri);
                } else {
                  showSnackBar(
                      title: "Thông báo", body: "Không thể mở tin nhắn!!");
                  throw 'Could not launch $uri';
                }
              },
              style: TextButton.styleFrom(primary: ColorConst.primaryColor),
              child: Text(
                "Nhắn tin",
                style: StyleConst.regularStyle(),
              )),
        ],
      ),
    );
  }
}
