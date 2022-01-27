import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget_html.dart';
import '../../config/theme/style-constant.dart';
import '../../shared/widget/widget_appbar.dart';

import '../../export.dart';
import 'components/slider_image_review.dart';
import 'components/widget_icon_back_page.dart';
import 'list_result_page.dart';

class DetailResultView extends StatefulWidget {
  final String appBarTitle;
  final String title;
  final String body;
  final List<String> images;

  const DetailResultView(
      {Key? key,
      required this.appBarTitle,
      required this.title,
      required this.body,
      required this.images})
      : super(key: key);

  @override
  _DetailResultViewState createState() => _DetailResultViewState();
}

class _DetailResultViewState extends State<DetailResultView> {
  num currentPos = 0;

  num fontSizeView = defaultSize;

  @override
  Widget build(BuildContext context) {
    Widget html = WidgetHtml(
      dataHtml: """
          ${widget.body}
          """,
      fontSize: fontSizeView.toDouble(),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(
            title: "${widget.appBarTitle}",
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
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
                  child: Column(
                    children: [
                      SliderImageReview(
                        currentPos: currentPos,
                        images: widget.images,
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
                              "${widget.title}",
                              style: StyleConst.boldStyle(fontSize: titleSize),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom:
                                      MediaQuery.of(context).padding.bottom +
                                          40),
                              child: html,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 50.0,
                    right: 50.0,
                    height: 100,
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
}
