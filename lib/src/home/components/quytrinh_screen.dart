import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/export.dart';
import 'package:viettel_app/models/document/document_model.dart';
import 'package:viettel_app/services/download_file/service.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_html.dart';
import 'package:viettel_app/shared/widget/widget_pdf_view.dart';
import 'package:viettel_app/src/home/controllers/quytrinh_controller.dart';

class QuyTrinhScreen extends StatefulWidget {
  final String title;
  final String groupCode;

  // List<QuyTrinhScreenDataTemple>? listData;

  QuyTrinhScreen({Key? key, required this.title, required this.groupCode})
      : super(key: key);

  @override
  _QuyTrinhScreenState createState() => _QuyTrinhScreenState();
}

class _QuyTrinhScreenState extends State<QuyTrinhScreen> {
  late QuyTrinhController quyTrinhController;
  ScrollController scrollController = ScrollController();
  StreamController<double> _stream = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stream.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // quyTrinhController = Get.put(QuyTrinhController(
    //     query: QueryInput(filter: {"groupCode": "${widget.groupCode}"})));
    quyTrinhController = Get.put(QuyTrinhController(
        query: QueryInput(filter: {})));
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        quyTrinhController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WidgetAppbar(
            title: "${widget.title}",
            turnOffSearch: true,
          ),
          Expanded(
            child: GetBuilder<QuyTrinhController>(builder: (controller) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: List.generate(
                      controller.loadMoreItems.value.length + 1, (index) {
                    if (index == controller.loadMoreItems.value.length) {
                      if (controller.loadMoreItems.value.length >=
                              (controller.pagination.value.limit ?? 10) ||
                          controller.loadMoreItems.value.length == 0) {
                        if (controller.lastItem == true) {
                          return WidgetLoading(
                            notData: controller.lastItem,
                            titleNotData: "Không có dự liệu",
                          );
                        }
                        return WidgetLoading(
                          notData: controller.lastItem,
                        );
                      } else {
                        // print("controller.lastItem---- ${controller.lastItem}");
                        return SizedBox.shrink();
                      }
                    }
                    if (controller.lastItem == false &&
                        controller.loadMoreItems.value.length == 0) {
                      return WidgetLoading();
                    }
                    return widgetItemQuyTrinh(
                        context, controller.loadMoreItems.value[index]);
                  }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget widgetItemQuyTrinh(BuildContext context, DocumentModel data) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: true,
              minChildSize: 0.3,
              initialChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10000,
                                    ),
                                    Center(
                                      child: Text(
                                        "${data.name}",
                                        style: StyleConst.boldStyle(
                                            fontSize: titleSize),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 34,
                                    ),

                                    ///- Đơn vị ban hành:  - Khu vực áp dụng: - Ghi chú:
                                    WidgetHtml(
                                      dataHtml: """ ${data.desc}""",
                                      fontSize: defaultSize,
                                    ),
                                    StreamBuilder<double>(
                                        stream: _stream.stream,
                                        builder: (context, snapshot) {
                                          return Column(
                                            children: List.generate(
                                                data.attachments?.length ?? 0,
                                                (index) => Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: ColorConst
                                                                      .borderInputColor))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              data
                                                                      .attachments?[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              style: StyleConst
                                                                  .mediumStyle(),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Visibility(
                                                              visible: data
                                                                      .attachments?[
                                                                          index]
                                                                      .mimetype ==
                                                                  "application/pdf",
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (_) => WidgetPDFView(
                                                                                  url: data.attachments?[index].downloadUrl ?? "",
                                                                                  name: data.attachments?[index].name ?? "",
                                                                                )));
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .visibility,
                                                                        color: ColorConst
                                                                            .primaryColor,
                                                                      )),
                                                            ),
                                                          ),
                                                          widgetDownload(
                                                              data: data.attachments?[
                                                                      index] ??
                                                                  Attachments(),
                                                              id: data.id ??
                                                                  ""),
                                                        ],
                                                      ),
                                                    )),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 64),
                        child: WidgetButton(
                          text: "Đóng",
                          radius: 100,
                          textColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: ColorConst.borderInputColor, width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.name}",
                    style: StyleConst.regularStyle(),
                  ),
                  Text(
                    "Xem thông tin",
                    style: StyleConst.regularStyle(
                        color: ColorConst.primaryColor, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetDownload({required Attachments data, required String id}) {
    if ((data.valueProgress) > 0.0) {
      if ((data.valueProgress) == 1.0) {
        print(data.file?.readAsBytesSync());
        return GestureDetector(
          onTap: () async {
            print("open file----${data.downloadUrl}");
            WaitingDialog.show(context);
            try {
              if (data.file != null) {
                print(
                    "data.attachments?.first.file?.path---- ${data.file?.path}");
                await OpenFile.open(data.file?.path);
              }
            } catch (error) {
              print("widgetDownload--- error: $error");
            }
            WaitingDialog.turnOff();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 2, right: 10, top: 2),
            decoration: BoxDecoration(
              color: ColorConst.primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              "Mở",
              style: StyleConst.mediumStyle(
                  color: ColorConst.white, fontSize: miniSize),
            ),
          ),
        );
      }
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
            backgroundColor: ColorConst.backgroundColor,
            value: data.valueProgress,
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(
              ColorConst.primaryColor,
            )),
      );
    }
    return GestureDetector(
      onTap: () async {
        WaitingDialog.show(context);
        try {
          print("data.downloadUrl1------- ${data.downloadUrl}");
          var dataDownload = await quyTrinhController.getOneDocument(id);
          data.downloadUrl = dataDownload.attachments
                  ?.firstWhere((element) => element.id == data.id)
                  .downloadUrl ??
              "";
          print("data.downloadUrl2------- ${data.downloadUrl}");
          data.file = await Service.downloadFile(data.downloadUrl ?? "",
              nameFile: data.name,
              // "https://sonnptnt.hungyen.gov.vn/portal/VanBan/2021-01/d540e9f8da1cc5bdtb02.pdf",
              onReceiveProgress: (value) {
            data.valueProgress = value;
            _stream.sink.add(data.valueProgress);
          });
        } catch (error) {
          print("widgetDownload----error: $error");
        }
        WaitingDialog.turnOff();
        print("data.attachments?.first.file?.path---- ${data.file?.path}");
        // showWaitingDialog(context);
      },
      child: Image.asset(
        AssetsConst.iconDown,
        width: 20,
        height: 20,
      ),
    );
  }
}

class QuyTrinhScreenDataTemple {
  String? title;
  String? name;
  String? downloadUrl;
  double valueDownload;
  File? file;

  QuyTrinhScreenDataTemple(
      {this.title,
      this.name,
      this.downloadUrl,
      this.valueDownload = 0.0,
      this.file});
}
