import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/src/camera_search/components/view_check_type_ai.dart';
import 'package:viettel_app/src/camera_search/controllers/camera_search_controller.dart';
import 'package:viettel_app/src/support/controllers/support_controller.dart';

import '../../../export.dart';

class SupportInput extends StatelessWidget {
  final ScrollController scrollController;

  SupportInput({Key? key, required this.scrollController}) : super(key: key);

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: MediaQuery.of(context).padding.bottom + 10),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: ColorConst.grey.withOpacity(.3),
            blurRadius: 10.0,
            offset: Offset(0.0, 0.5)),
      ], color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          // Image.asset(
          //   AssetsConst.iconSupportCamera,
          //   width: 23,
          //   height: 19,
          // ),
          // SizedBox(width: 20,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  border: Border.all(color: ColorConst.borderInputColor)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: StyleConst.mediumStyle(),
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 10),
                          border: InputBorder.none,
                          labelStyle: StyleConst.mediumStyle(),
                          hintStyle:
                              StyleConst.mediumStyle(color: ColorConst.grey),
                          hintText: "Nhập nội dung...."),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Image.asset(
                  //     AssetsConst.iconSupportAlbumImage,
                  //     width: 17,
                  //     height: 17,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5,right: 20),
                  //   child: Image.asset(
                  //     AssetsConst.iconSupportFile,
                  //     width: 17,
                  //     height: 17,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
              onTap: () async {
                if (Get.find<SupportController>().initSessionModel == null) {
                  try {
                    CameraSearchController cameraController =
                        Get.find<CameraSearchController>();
                    WaitingDialog.show(context);
                    await Get.find<SupportController>().initSupport(
                        cameraController.imageNetWorks, cameraController.type);
                    WaitingDialog.turnOff();
                    Get.find<SupportController>()
                        .insertMessages(textEditingController.text);
                    textEditingController.clear();
                    // FocusScope.of(context).requestFocus(new FocusNode());
                    scrollController.animateTo(0.0,
                        duration: Duration(microseconds: 100),
                        curve: Curves.ease);
                  } catch (error) {
                    viewTypeAI.showSelectedType(context, (value) async {
                      print(value);
                      WaitingDialog.show(context);

                      await Get.find<SupportController>()
                          .initSupport([], value == 1 ? "Worm" : "Disease");
                      WaitingDialog.turnOff();

                      Get.find<SupportController>()
                          .insertMessages(textEditingController.text);
                      textEditingController.clear();
                      // FocusScope.of(context).requestFocus(new FocusNode());
                      scrollController.animateTo(0.0,
                          duration: Duration(microseconds: 100),
                          curve: Curves.ease);
                    });
                  }
                } else {
                  await Get.find<SupportController>()
                      .insertMessages(textEditingController.text);

                  textEditingController.clear();
                  // FocusScope.of(context).requestFocus(new FocusNode());
                  scrollController.animateTo(0.0,
                      duration: Duration(microseconds: 100),
                      curve: Curves.ease);
                }
              },
              child: Icon(
                Icons.send,
                size: 30,
                color: ColorConst.primaryColor,
              ))
        ],
      ),
    );
  }
}
