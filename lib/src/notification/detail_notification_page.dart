import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';

import '../../export.dart';
import 'controllers/notification_controller.dart';

class DetailNotificationPage extends StatelessWidget {
  final String id;

  const DetailNotificationPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getOneNotification(id, context);
    return Container(
      color: ColorConst.white,
      child: Column(
        children: [
          WidgetAppbar(
            title: "Thông báo",
            turnOffNotification: true,
            turnOffSearch: true,
          ),
          GetBuilder<NotificationController>(builder: (controller) {
            if (controller.notificationDetail == null) {
              return SizedBox();
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetImageNetWork(
                    url: controller.notificationDetail?.image,
                    height: 243,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    controller.notificationDetail?.title ?? "",
                    style: StyleConst.mediumStyle(fontSize: titleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: WidgetIconText(
                      iconAsset: AssetsConst.iconTime,
                      text: controller.notificationDetail?.createdAt ?? "",
                      size: 12,
                      colorIcon: ColorConst.grey,
                      style: StyleConst.regularStyle(color: ColorConst.grey),
                    ),
                  ),
                  Text(
                    controller.notificationDetail?.body ?? "",
                    style: StyleConst.regularStyle(height: 1.4),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
