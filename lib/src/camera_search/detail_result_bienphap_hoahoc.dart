import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/library/disease_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_drop_children.dart';
import 'package:viettel_app/shared/widget/widget_search.dart';
import 'package:get/get.dart';
import '../../export.dart';
import 'components/slider_image_review.dart';
import 'components/widget_icon_back_page.dart';
import 'components/widget_item_event.dart';
import 'controllers/medicine_controller.dart';
import 'list_result_page.dart';

class DetailResultBienPhapHoaHoc extends StatefulWidget {
  final DiseaseModel data;

  const DetailResultBienPhapHoaHoc({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _DetailResultBienPhapHoaHocState createState() =>
      _DetailResultBienPhapHoaHocState();
}

class _DetailResultBienPhapHoaHocState
    extends State<DetailResultBienPhapHoaHoc> {
  num currentPos = 0;

  num indexBody = 0;
  MedicineController medicineController = Get.put(MedicineController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(
            title: "Biện pháp hoá học",
            turnOffSearch: true,
            widgetIconStart: WidgetIconBackPage(),
            callBack: () {
              if (indexBody == 1 || indexBody == 0) {
                Get.back();
                ListResultPage.countPage -= 1;
              } else {
                setState(() {
                  indexBody -= 1;
                });
              }
            },
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(
                bottom: 10 + MediaQuery.of(context).padding.bottom),
            child: indexBodyReturn(),
          ))
        ],
      ),
    );
  }

  Widget indexBodyReturn() {
    switch (indexBody) {
      case 0:
        return widgetCanhBao();
      case 2:
        return widgetBody2();
      default:
        return widgetBody1();
      // case 3:
      //   return widgetBody3();
      // default:
      //   return SizedBox();
    }
  }

  Widget widgetCanhBao() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 46, bottom: 44.1),
            child: Image.asset(
              AssetsConst.imageCanhBao,
              width: 130,
              height: 116,
            ),
          ),
          Text(
            "Khuyến cáo",
            style: StyleConst.boldStyle(fontSize: titleSize),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              """Sử dụng thuốc BVTV hóa học phải tuân thủ nguyên tắc "4 đúng": Đúng thuốc; Đúng lúc; Đúng liều lượng và nồng độ; Đúng cách. Ngoài ra còn phải tuân thủ đúng thời gian cách ly.
               \nSử dụng thuốc BVTV hóa học không theo nguyên tắc "4 đúng" có thể làm gia tăng tính kháng thuốc của sinh vật gây hại, gây ngộ độc cho người sử dụng, cây trồng, gia súc, gia cầm và gây ô nhiễm môi trường.
              
              """,
              style: StyleConst.regularStyle(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: WidgetButton(
              text: "Tôi đồng ý",
              textColor: Colors.white,
              radius: 100,
              onTap: () {
                setState(() {
                  indexBody = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBody1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 22, right: 16, left: 16, bottom: 3),
          child: WidgetSearch(
            controller: textEditingController,
            hintText: "Nhập nội dung tìm kiếm",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            "Tổng: ${widget.data.ingredients?.length} Hoạt chất",
            style: StyleConst.regularStyle(),
          ),
        ),
        Container(
          height: 2,
          color: ColorConst.backgroundColor,
        ),
        Column(
          children: List.generate(
            widget.data.ingredients?.length ?? 0,
            (index) => WidgetItemEvent(
              widget.data.ingredients?[index].name ?? "",
              onTap: () {
                medicineController.loadAll(
                    query: QueryInput(filter: {
                  "ingredientIds": "${widget.data.ingredients?[index].id}"
                }));
                setState(() {
                  indexBody = 2;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetBody2() {
    return GetBuilder<MedicineController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 22, right: 16, left: 16, bottom: 3),
              child: WidgetSearch(
                controller: textEditingController,
                hintText: "Nhập nội dung tìm kiếm",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Tổng: ${controller.loadMoreItems.value.length} thuốc",
                style: StyleConst.regularStyle(),
              ),
            ),
            Container(
              height: 2,
              color: ColorConst.backgroundColor,
            ),
            Column(
              children: List.generate(
                controller.loadMoreItems.value.length,
                (index) => WidgetItemEvent(
                    controller.loadMoreItems.value[index].name ?? "",
                    onTap: () async {
                  String url = "";

                  if (Platform.isAndroid) {
                    // Android-specific code
                    url =
                        "https://play.google.com/store/apps/details?id=eha.sv.ecofarm";
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    url =
                        "https://apps.apple.com/vn/app/thu%E1%BB%91c-bvtv/id1432436909";
                  }

                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
              ),
            )
          ],
        );
      },
    );
  }

  Widget widgetBody3() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Image.network(
              "https://tapdoanvinasa.com/wp-content/uploads/2019/12/bump-01.jpg",
              width: 128,
              height: 128,
            ),
          ),
          WidgetDropChildren(
            title: "Thông tin chung",
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Số",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "1234/CNĐKT-BVTV",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Thời gian",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "28/03/2018 - 28/03/2023",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Hoạt chất",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Hàm lượng",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Nhóm thuốc",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Nhóm độc",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          WidgetDropChildren(
            title: "Phạm vi sử dụng",
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Liều lượng",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Cách xử lý",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Cách dùng",
                              style: StyleConst.regularStyle(),
                            ),
                          ),
                          Text(
                            "N/A",
                            style: StyleConst.regularStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
