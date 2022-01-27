import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/support/init_session_model.dart';
import 'package:viettel_app/models/support/message_model.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/support/controllers/support_controller.dart';

import '../../export.dart';
import 'components/support_input.dart';
import 'components/support_item_mine.dart';
import 'components/support_item_their.dart';
import 'list_session_page.dart';

class SupportPage extends StatefulWidget {
  InitSessionModel? initSessionModel;

  SupportPage({Key? key, this.initSessionModel}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  SupportController _supportController = Get.find<SupportController>();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initSessionModel != null) {
      _supportController.initSessionModel = widget.initSessionModel;
      _supportController.listData = [];
      _supportController.pageIndex = 0;
      _supportController.getAllMessage();
    }
    scrollController.addListener(() async {
      // print(scrollController.position.pixels);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_supportController.lastItemMessage = false) {
          _supportController.pageIndex += 1;
          _supportController.getAllMessage();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: ColorConst.white,
          child: Column(
            children: [
              WidgetAppbar(
                title: "Chuyên gia hỗ trợ",
                turnOffNotification: true,
                turnOffSearch: true,
                widgetIcons: GestureDetector(
                  onTap: () {
                    Get.to(ListSessionPage());
                  },
                  child: Image.asset(
                    AssetsConst.iconHistorySupport,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              GetBuilder<SupportController>(builder: (controller) {
                // print(
                //     "controller.listData.length---- ${controller.listData.length}");
                return Expanded(
                    child: SingleChildScrollView(
                  controller: scrollController,
                  reverse: true,
                  child: Column(
                    children: List.generate(
                        controller.listData.length,
                        (index) =>
                            renderWidgetMessage(controller.listData[index])),
                  ),
                ));
              }),
              SupportInput(
                scrollController: scrollController,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderWidgetMessage(MessageModel data) {
    if (data.createdUserID != null) {
      return SupportItemMine(
        data: data,
      );
    } else {
      return SupportItemTheir(
        data: data,
      );
    }
  }
}
