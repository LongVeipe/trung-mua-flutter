import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_html.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';

import '../../export.dart';

class TinTucDetailPage extends StatefulWidget {
  final String id;

  TinTucDetailPage({Key? key, required this.id}) : super(key: key);

  static push(BuildContext context, {required String id}) {
    Get.to(TinTucDetailPage(
      id: id,
    ));
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (_) => TinTucDetailPage(id: id,)));
  }

  @override
  _TinTucDetailPageState createState() => _TinTucDetailPageState();
}

class _TinTucDetailPageState extends State<TinTucDetailPage> {
  double fontSlider = defaultSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<PostsController>().getOnePost(widget.id);
  }
  final spinKit = SpinKitCircle(
    color: ColorConst.primaryColor,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      builder: (controller) {
        if (controller.tinTucDetail == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                WidgetAppbar(
                  title: "Tin tức",
                ),
                Expanded(
                  child: Center(
                    child: spinKit,
                  ),
                ),
              ],
            ),
          );
        }

        Widget html = WidgetHtml(
          dataHtml: """
          ${controller.tinTucDetail?.content ?? ""}
          """,
          fontSize: fontSlider,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                WidgetAppbar(
                  title: "Tin tức",
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        // physics: const BouncingScrollPhysics(
                        //     parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          children: [
                            WidgetImageNetWork(
                              url: controller.tinTucDetail?.featureImage,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,

                            ),
                            titleContainer(context,
                                text: controller.tinTucDetail?.title,
                                time: controller.tinTucDetail?.createdAt),
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
                                    if (fontSlider >= defaultSize + 2) {
                                      setState(() {
                                        fontSlider = fontSlider - 2;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.zoom_out,
                                      size: 30, color: ColorConst.textPrimary),
                                ),
                                Expanded(
                                  child: Slider(
                                      divisions:
                                          ((supTitleSize - defaultSize) ~/ 2)
                                              .toInt(),
                                      min: defaultSize,
                                      max: supTitleSize,
                                      value: fontSlider,
                                      inactiveColor: ColorConst.grey,
                                      activeColor: ColorConst.primaryColor,
                                      onChanged: (v) {
                                        setState(() {
                                          fontSlider = v;
                                        });
                                        // _htmlFontBehavior.sink.add(fontSlider);
                                      }),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(fontSlider);
                                    if (fontSlider <= supTitleSize - 2) {
                                      setState(() {
                                        fontSlider = fontSlider + 2;
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
          ),
        );
      },
    );
  }

  Widget titleContainer(BuildContext context, {String? text, String? time}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text".toUpperCase(),
            style: StyleConst.boldStyle(fontSize: titleSize, height: 1.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          WidgetIconText(
            iconAsset: AssetsConst.iconTime,
            text: "Ngày đăng: $time",
            size: 12,
            style: StyleConst.regularStyle(),
          ),
        ],
      ),
    );
  }
}
