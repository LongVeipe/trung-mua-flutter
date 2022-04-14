import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget_html.dart';
import '../../config/theme/color-constant.dart';
import '../../config/theme/style-constant.dart';
import '../../models/library/disease_model.dart';
import '../../shared/widget/widget_appbar.dart';
import 'detail_result_bienphap_phongchong.dart';
import '../library/controllers/library_controller.dart';

import '../../export.dart';
import 'components/slider_image_review.dart';
import 'components/widget_item_event.dart';
import 'detail_result_view.dart';
import 'list_result_page.dart';

class DetailResultPage extends StatefulWidget {
  final String? id;
  final String? tag;
  final DiseaseModel? diseaseModel;

  const DetailResultPage({Key? key, this.id, this.tag,this.diseaseModel})
      : super(key: key);

  @override
  _DetailResultPageState createState() => _DetailResultPageState();
}

class _DetailResultPageState extends State<DetailResultPage> {
  num currentPos = 0;
  num fontSizeView=defaultSize;



  late LibraryController libraryController;
  DiseaseModel? diseaseModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      libraryController = Get.find<LibraryController>(tag: widget.tag);
    } catch (error) {
      libraryController = Get.put(LibraryController(), tag: widget.tag);
    }
    print(widget.id);
    if(widget.diseaseModel==null&&widget.id!=null)
    libraryController.getOneDisease(widget.id??"");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(title: "Kết Quả", turnOffSearch: true,callBack: (){
            ListResultPage.countPage-=1;
            Get.back();
          },),

          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  child: GetBuilder<LibraryController>(builder: (controller) {
                    if(widget.diseaseModel!=null){
                      diseaseModel=widget.diseaseModel;
                    }
                    else{
                      diseaseModel=controller.diseaseDetail;
                    }
                    return Column(children: [
                      SliderImageReview(
                        currentPos: currentPos,
                        images: diseaseModel?.images ?? [],
                      ),

                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            height: 2,
                            color: ColorConst.primaryBackgroundLight,
                          ),
                          WidgetItemEvent("Triệu chứng", onTap: () {
                            // Get.to(DetailResultTrieuChungPage());
                            ListResultPage.countPage+=1;
                            Get.to(DetailResultView(
                              appBarTitle: "Triệu chứng",
                              title:
                              "Triệu chứng ${diseaseModel?.name ?? ""}",
                              body: diseaseModel?.symptom ?? "",
                              images: diseaseModel?.images ?? [],
                            ));
                          }),
                          WidgetItemEvent("Một số đặc điểm sinh học, sinh thái",
                              onTap: () {
                                ListResultPage.countPage+=1;
                                Get.to(DetailResultView(
                                  appBarTitle: "Đặc điểm sinh học, sinh thái",
                                  title:
                                  "Đặc điểm sinh học, sinh thái ${diseaseModel?.name ?? ""}",
                                  body: diseaseModel?.bio ?? "",
                                  images: diseaseModel?.images ?? [],
                                ));
                              }),
                          WidgetItemEvent("Biện pháp phòng chống", onTap: () {
                            ListResultPage.countPage+=1;
                            Get.to(DetailResultBienPhapPhongChong(
                              data: diseaseModel ?? DiseaseModel(),
                            ));
                          }),
                        ],
                      ),
                      SizedBox(height: 30,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10000,
                            ),
                            Text(
                              diseaseModel?.name ?? "",
                              style: StyleConst.boldStyle(fontSize:fontSizeView +( titleSize- defaultSize) ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            WidgetHtml(
                              dataHtml: """
                                    ${diseaseModel?.desc ?? ""}
                                    """,
                              fontSize: fontSizeView.toDouble(),
                            )

                          ],
                        ),
                      ),

                      SizedBox(height: 100+ MediaQuery.of(context).padding.bottom,)
                    ]);
                  }),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom+20,
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
                                ((supTitleSize - defaultSize) ~/ 2)
                                    .toInt(),
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

          // SliderImageReview(
          //   currentPos: currentPos,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         width: 10000,
          //       ),
          //       Text(
          //         "Bệnh Đạo Ôn Lá",
          //         style: StyleConst.boldStyle(fontSize: titleSize),
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       RichText(
          //           text: TextSpan(children: [
          //         TextSpan(
          //             text: "Tên gọi khác: ", style: StyleConst.regularStyle()),
          //         TextSpan(text: "Bệnh cháy lá", style: StyleConst.boldStyle()),
          //       ])),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       Text(
          //         "Tên khoa học:  Magnaporthe grisea (Hebert) Barr (Piricularia oryzae Carava)",
          //         style: StyleConst.regularStyle(),
          //       ),
          //     ],
          //   ),
          // ),
          // Column(
          //   children: [
          //     Container(
          //       margin: EdgeInsets.only(top: 16),
          //       height: 2,
          //       color: ColorConst.backgroundColor,
          //     ),
          //     WidgetItemEvent("Triệu chứng", onTap: () {
          //       // Get.to(DetailResultTrieuChungPage());
          //       Get.to(DetailResultView(
          //         appBarTitle: "Triệu chứng",
          //         title: "Triệu chứng Bệnh Đạo Ôn Lá",
          //         body:
          //             "- Trên lá: Vết bệnh thay đổi từ hình tròn nhỏ, chấm đen tới hình “oval” với viền hẹp màu nâu đỏ nhạt và có màu xám ở trung tâm, rồi lan rộng dần ra thành hình thoi (hình mắt én). Nếu bị nặng có thể làm lá bị khô cháy, cây lúa lụi tàn."
          //             "\n\n- Trên cổ lá, trên thân: Bệnh làm thối cổ lá: Vết bệnh hơi lõm vào, có màu nâu sậm đến đen. Bệnh làm thối và gãy đốt thân, nặng có thể làm gãy ngang đốt thân."
          //             "\n\n- Trên cổ bông: Bệnh gây hại trên bông làm gãy cổ bông, gãy gié dẫn đến hạt lúa sẽ bị lem lép.",
          //       ));
          //     }),
          //     WidgetItemEvent("Một số đặc điểm sinh học, sinh thái", onTap: () {
          //       Get.to(DetailResultView(
          //         appBarTitle: "Đặc điểm sinh học, sinh thái",
          //         title: "Đặc điểm sinh học, sinh thái Bệnh Đạo Ôn Lá",
          //         body:
          //             "Nấm tồn tại trên tàn dư cây trồng, lúa chét, cỏ dại. Bào tử thường phát sinh vào ban đêm. Tính gây bệnh thay đổi tùy theo giống và vùng địa lý. Trong điều kiện ẩm độ cao số bào tử mọc ra rất nhiều."
          //             "\n\nPhạm vi nhiệt độ hình thành bào tử từ 10 – 30oC, nhưng thích hợp là từ 20 - 30 oC và độ ẩm trên 80%."
          //             " Trong vụ Đông Xuân, biên độ nhiệt giữa ngày và đêm cao sẽ dễ phát sinh thành dịch, trời âm u, "
          //             "có mưa phùn, sương mù liên tục trong nhiều ngày là điều kiện rất thuận lợi cho bệnh đạo ôn lây lan,"
          //             " phát triển và gây hại nặng. Trong điều kiện khô hạn, ẩm độ đất thấp hoặc ở điều kiện ngập úng kéo dài "
          //             "cây lúa dễ bị nhiễm bệnh. Những chân ruộng nhiều mùn, trũng, khó thoát nước; những vùng đất mới vỡ hoang,"
          //             " đất nhẹ giữ nước kém, khô hạn và những chân ruộng có lớp sét nông rất phù hợp cho nấm bệnh phát triển gây"
          //             " hại.",
          //       ));
          //     }),
          //     WidgetItemEvent("Biện pháp phòng chống", onTap: () {
          //       Get.to(DetailResultBienPhapPhongChong());
          //     }),
          //   ],
          // )
        ],
      ),
    );
  }

  String getTextType(String type) {
    if (type == "BENH") return "Bệnh";
    if (type == "SAU") return "Sâu";
    return "";
  }
}
