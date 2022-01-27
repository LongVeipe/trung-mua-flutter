import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget-dialog.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/support/controllers/support_controller.dart';
import 'package:viettel_app/src/support/support_page.dart';

import '../../export.dart';

class ListSessionPage extends StatefulWidget {
  const ListSessionPage({Key? key}) : super(key: key);

  @override
  _ListSessionPageState createState() => _ListSessionPageState();
}

class _ListSessionPageState extends State<ListSessionPage> {
  ScrollController scrollController = ScrollController();
  SupportController _supportController = Get.find<SupportController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      // print(scrollController.position.pixels);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_supportController.lastItemSession==false) {
          _supportController.pageIndex2 += 1;
          _supportController.getAllSessionByUser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SupportController>().getAllSessionByUser();

    return Scaffold(
      body: Column(
        children: [
          WidgetAppbar(
            title: "Danh sách hội thoại",
            turnOffNotification: true,
            turnOffSearch: true,

          ),
          Expanded(
            child: GetBuilder<SupportController>(builder: (controller) {
              return SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      (controller.listSession?.length ?? 0) + 1, (index) {
                    if (index == (controller.listSession?.length ?? 0)) {
                      return WidgetLoading(
                        notData: controller.lastItemSession,
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Get.to(SupportPage(
                          initSessionModel: controller.listSession?[index],
                        ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            AssetsConst.iconSupportLogoViettel,
                            width: 60,
                            height: 60,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorConst.borderInputColor)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.listSession?[index].className ?? ""}",
                                          style: StyleConst.boldStyle(),
                                        ),
                                        Text(
                                          controller.listSession?[index]
                                                  .createdTime ??
                                              "",
                                          style: StyleConst.regularStyle(
                                              height: 1.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      WidgetDialog.eventShowDialog(
                                          context: context,
                                          title: "Xác nhận",
                                          body:
                                              "Bạn có muốn đóng cuộc hội thoại này không?",
                                          callSuccess: () {
                                            if (controller
                                                    .listSession?[index].id !=
                                                null) {
                                              controller.closeSession(controller
                                                      .listSession?[index].id ??
                                                  0);
                                            }
                                          });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorConst.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
