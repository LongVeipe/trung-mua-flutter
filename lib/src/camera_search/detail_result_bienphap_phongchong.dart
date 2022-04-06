import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget_html.dart';
import '../../config/theme/color-constant.dart';
import '../../config/theme/style-constant.dart';
import '../../models/library/disease_model.dart';
import '../../shared/widget/widget_appbar.dart';

import '../../export.dart';
import 'components/slider_image_review.dart';
import 'components/widget_icon_back_page.dart';
import 'detail_result_bienphap_hoahoc.dart';
import 'detail_result_view.dart';
import 'list_result_page.dart';

class DetailResultBienPhapPhongChong extends StatefulWidget {
  final DiseaseModel data;

  const DetailResultBienPhapPhongChong({Key? key, required this.data})
      : super(key: key);

  @override
  _DetailResultBienPhapPhongChongState createState() =>
      _DetailResultBienPhapPhongChongState();
}

class _DetailResultBienPhapPhongChongState
    extends State<DetailResultBienPhapPhongChong> {
  num currentPos = 0;
  num fontSizeView = defaultSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(
            title: "Biện pháp phòng chống",
            turnOffSearch: true,
            widgetIconStart: WidgetIconBackPage(),
            callBack: () {
              ListResultPage.countPage -= 1;
              Get.back();
            },
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SliderImageReview(
                        currentPos: currentPos,
                        images: widget.data.images ?? [],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            height: 2,
                            color: ColorConst.primaryBackgroundLight,
                          ),
                          widgetItemEvent("Biện pháp canh tác", onTap: () {
                            // Get.to(DetailResultTrieuChungPage());
                            ListResultPage.countPage += 1;

                            Get.to(DetailResultView(
                              appBarTitle: "Biện pháp canh tác",
                              title:
                                  "Biện pháp canh tác ${widget.data.name ?? ""}",
                              body: widget.data.farmingSolution ?? "",
                              images: widget.data.images ?? [],
                            ));
                          }),
                          widgetItemEvent("Biện pháp sinh học", onTap: () {
                            ListResultPage.countPage += 1;

                            Get.to(DetailResultView(
                              appBarTitle: "Biện pháp sinh học",
                              title:
                                  "Biện pháp sinh học ${widget.data.name ?? ""}",
                              body: widget.data.bioSolution ?? "",
                              images: widget.data.images ?? [],
                            ));
                          }),
                          widgetItemEvent("Biện pháp hóa học", onTap: () {
                            ListResultPage.countPage += 1;
                            Get.to(DetailResultBienPhapHoaHoc(
                              data: widget.data,
                            ));
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10000,
                            ),
                            Text(
                              "Biện pháp phòng chống ${widget.data.name ?? ""}",
                              style: StyleConst.boldStyle(fontSize: titleSize),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            WidgetHtml(
                              dataHtml: """${widget.data.desc ?? ""}""",
                              fontSize: fontSizeView.toDouble(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100 + MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                    left: 50.0,
                    right: 50.0,
                    height: 50,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Row(children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (fontSizeView >= defaultSize + 2) {
                                setState(() {
                                  fontSizeView = fontSizeView - 2;
                                });
                              }
                            },
                            child: Icon(Icons.zoom_out,
                                size: 30, color: ColorConst.textPrimary),
                          ),
                          Expanded(
                            child: Slider(
                                divisions:
                                    ((supTitleSize - defaultSize) ~/ 2).toInt(),
                                min: defaultSize,
                                max: supTitleSize,
                                value: fontSizeView.toDouble(),
                                inactiveColor: ColorConst.grey,
                                activeColor: ColorConst.primaryColor,
                                onChanged: (v) {
                                  setState(() {
                                    fontSizeView = v;
                                  });
                                  // _htmlFontBehavior.sink.add(fontSlider);
                                }),
                          ),
                          GestureDetector(
                            onTap: () {
                              print(fontSizeView);
                              if (fontSizeView <= supTitleSize - 2) {
                                setState(() {
                                  fontSizeView = fontSizeView + 2;
                                });
                              }
                            },
                            child: Icon(Icons.zoom_in,
                                size: 30, color: ColorConst.textPrimary),
                          ),
                        ])))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget widgetItemEvent(String title, {Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: ColorConst.primaryBackgroundLight, width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              style: StyleConst.mediumStyle(fontSize: titleSize),
            ),
            Icon(
              Icons.navigate_next,
              color: ColorConst.grey,
            )
          ],
        ),
      ),
    );
  }
}
