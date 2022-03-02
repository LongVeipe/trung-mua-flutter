import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/support/controllers/support_controller.dart';
import 'package:viettel_app/src/support/support_page.dart';

import '../../export.dart';
import 'components/slider_image_review.dart';
import 'controllers/camera_search_controller.dart';
import 'detail_result_page.dart';

class ListResultPage extends StatefulWidget {
  const ListResultPage({Key? key}) : super(key: key);

  static int countPage=0;
  @override
  _ListResultPageState createState() => _ListResultPageState();
}

class _ListResultPageState extends State<ListResultPage> {
  bool showIconChatBot = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              WidgetAppbar(title: "Kết Quả"),
              GetBuilder<CameraSearchController>(builder: (controller) {
                // if (controller.scanDiseaseCurrent != null) {
                //   return noData("Không tìm thấy");
                // }

                return Expanded(
                  child: SingleChildScrollView(
                    child: (controller.scanDiseaseCurrent?.results?.length ??
                                    0) >
                                0 &&
                            controller.scanDiseaseCurrent != null
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(16),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        ColorConst.primaryColor.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Dựa vào hình ảnh mà bạn cung cấp, ứng dụng sẽ cung cấp danh "
                                  "sách các kết quả gần giống nhất với sinh vật gây hại mà bạn đang tìm kiếm.",
                                  style: StyleConst.regularStyle(),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Column(
                                children: List.generate(
                                    controller.scanDiseaseCurrent?.results
                                            ?.length ??
                                        0,
                                    (index) => widgetItemKetQua(controller
                                            .scanDiseaseCurrent
                                            ?.results?[index] ??
                                        Results())),
                              )
                            ],
                          )
                        : noData("Không tìm thấy."),
                  ),
                );
              }),
            ],
          ),
          // Visibility(
          //   visible: showIconChatBot,
          //   child: Positioned(
          //       right: 20,
          //       bottom: 30 + MediaQuery.of(context).padding.bottom,
          //       child: GestureDetector(
          //         onTap: () async {
          //
          //           Get.to(SupportPage());
          //         },
          //         child: Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.all(10),
          //               decoration: BoxDecoration(
          //                   color: ColorConst.backgroundColor,
          //                   borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(50),
          //                     bottomLeft: Radius.circular(50),
          //                     bottomRight: Radius.circular(50),
          //                   )),
          //               child: Text(
          //                 "Không tìm thấy?\nChuyên gia sẵn sàng hỗ trợ bạn!",
          //                 style: StyleConst.regularStyle(),
          //                 textAlign: TextAlign.right,
          //               ),
          //             ),
          //             Stack(
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Image.asset(
          //                     AssetsConst.iconChatBot,
          //                     width: 58,
          //                     height: 58,
          //                   ),
          //                 ),
          //                 Positioned(
          //                     top: 0,
          //                     right: 0,
          //                     child: GestureDetector(
          //                         onTap: () {
          //                           setState(() {
          //                             showIconChatBot = false;
          //                           });
          //                         },
          //                         child: Icon(
          //                           Icons.clear,
          //                           color: ColorConst.grey,
          //                           size: 16,
          //                         )))
          //               ],
          //             )
          //           ],
          //         ),
          //       )),
          // )
        ],
      ),
    );
  }

  Widget widgetItemKetQua(Results data) {
    return GestureDetector(
      onTap: () {
        ListResultPage.countPage+=1;
        Get.to(DetailResultPage(
          // id: data.id ?? "",
          diseaseModel: data.disease,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: ColorConst.backgroundColor, width: 2))),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: WidgetImageNetWork(
                  url: data.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.className ?? "",
                    style: StyleConst.boldStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(height: 5,),
                  WidgetIconText(
                    iconAsset: AssetsConst.iconTime,
                    text: "${  data.disease?.createdAt??""}",
                    size: 12,
                    style: StyleConst.regularStyle(fontSize: miniSize),
                  ),

                  // Text(
                  //   "Tên gọi khác: Magnaporthe grisea (Hebert) Barr (Piricularia oryzae Carava)",
                  //   style: StyleConst.regularStyle(height: 1.5),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noData(String body) {
    return Column(
      children: [
        SizedBox(
          height: 64,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Image.asset(
            "assets/images/image_not_fond_disease.png",
            width: 116,
            height: 116,
          ),
        ),
        Text(
          body,
          style: StyleConst.boldStyle(fontSize: titleSize),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Sinh vật gây hại này chưa có trong cơ sở dữ liệu. Vui lòng cung cấp hình ảnh tới chuyên gia.",
          style: StyleConst.regularStyle(height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
