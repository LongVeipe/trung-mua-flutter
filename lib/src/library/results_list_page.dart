import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/camera_search/detail_result_page.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import '../../export.dart';

class ResultsListPage extends StatelessWidget {
  final List<Results>? results;

  const ResultsListPage({Key? key, this.results}) : super(key: key);

  static int countPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          WidgetAppbar(title: "Danh Sách Kết Quả"),
          Expanded(
              child: SingleChildScrollView(
            child: (results?.length ?? 0) > 0
                ? Column(
                    children: List.generate(
                        results?.length ?? 0,
                        (index) =>
                            widgetItemKetQua(results?[index] ?? Results())),
                  )
                : noData("Không tìm thấy."),
          )),
        ]));
  }

  Widget widgetItemKetQua(Results data) {
    return GestureDetector(
      onTap: () {
        ResultsListPage.countPage += 1;
        Get.to(DetailResultPage(
          diseaseModel: data.disease,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: ColorConst.primaryBackgroundLight, width: 2))),
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
                    data.disease?.name ?? "",
                    style: StyleConst.boldStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // WidgetIconText(
                  //   iconAsset: AssetsConst.iconTime,
                  //   text: "${data.disease?.createdAt ?? ""}",
                  //   size: miniSize,
                  //   style: StyleConst.regularStyle(fontSize: miniSize),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Tên gọi khác: ${data.disease?.alternativeName ?? "Không có"}",
                    style: StyleConst.regularStyle(fontSize: miniSize),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Độ chính xác: ${data.accuracy ?? "Không rõ"}%",
                    style: StyleConst.regularStyle(fontSize: miniSize)
                  )
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
