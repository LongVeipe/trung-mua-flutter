import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/notification/notification_model.dart';
import 'package:viettel_app/services/firebase/notify_event.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/widget/widget-dialog.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/notification/controllers/notification_controller.dart';

import '../../export.dart';
import 'detail_notification_page.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  double width = 0.0;

  NotificationController notificationController =
      Get.put(NotificationController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotifyEvent.addItemListener(
        key: "NotificationPage",
        function: (value) {
          notificationController.service.clearCache();
          notificationController.loadAll();
        });
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        notificationController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.white,
      child: Column(
        children: [
          WidgetAppbar(
            title: "Thông báo",
            turnOffNotification: true,
            turnOffSearch: true,
            widgetIcons: GestureDetector(
              onTap: () {
                WidgetDialog.eventShowDialog(
                    context: context,
                    title: "Đọc Tất Cả",
                    body:
                        "Bạn có muốn đánh dấu tất cả các thông báo là đã đọc?",
                    callSuccess: () {
                      notificationController.readAllNotification();
                    });
              },
              child: ImageIcon(
                AssetImage(AssetsConst.iconCheckSeeAll),
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<NotificationController>(builder: (controller) {
              if (controller.initialized == false) {
                return SizedBox();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  print("RefreshIndicator...");
                  controller.refreshData();
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: List.generate(
                        controller.loadMoreItems.value.length+1, (index) {
                      // print(controller.loadMoreItems.value[index].id);

                      if (index == controller.loadMoreItems.value.length) {
                        if (controller.loadMoreItems.value.length >=
                            (controller.pagination.value.limit ?? 10) ||
                            controller.loadMoreItems.value.length == 0) {
                          return WidgetLoading(
                            notData: controller.lastItem,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                      if (controller.lastItem == false &&
                          controller.loadMoreItems.value.length == 0) {
                        return WidgetLoading();
                      }

                      return Opacity(
                          opacity:
                              controller.loadMoreItems.value[index].seen == true
                                  ? .5
                                  : 1.0,
                          child: itemWidgetNotification(
                              controller.loadMoreItems.value[index], context));
                    }),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget itemWidgetNotification(NotificationModel data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.id != null) {
          // Get.find<NotificationController>().getOneNotification(data.id ?? "",context);

          Get.to(DetailNotificationPage(
            id: data.id ?? "",
          ));
        }
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: ColorConst.borderInputColor))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data.title}",
              style: StyleConst.regularStyle(fontSize: titleSize),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${data.body}",
              style: StyleConst.regularStyle(height: 1.4),
            ),
            SizedBox(
              height: 5,
            ),
            WidgetIconText(
              iconAsset: AssetsConst.iconTime,
              text: "${data.createdAt}",
              size: 12,
              colorIcon: ColorConst.grey,
              style: StyleConst.regularStyle(color: ColorConst.grey),
            ),
          ],
        ),
      ),
    );
  }
}
