import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/camera_search/detail_result_page.dart';
import 'package:viettel_app/src/components/item_tintuc_component.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/library/controllers/history_disease_scan_controller.dart';

import '../../../export.dart';

class IdentifiedRecentlyScreen extends StatefulWidget {
  const IdentifiedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _IdentifiedRecentlyScreenState createState() =>
      _IdentifiedRecentlyScreenState();
}

class _IdentifiedRecentlyScreenState extends State<IdentifiedRecentlyScreen> {
  ScrollController scrollController = ScrollController();
  HistoryDiseaseScanController _historyDiseaseScanController =
  Get.put(HistoryDiseaseScanController(), tag: "IdentifiedRecentlyScreen");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _historyDiseaseScanController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorConst.backgroundColor,
        child: GetBuilder<HistoryDiseaseScanController>(
          tag: "IdentifiedRecentlyScreen",
          builder: (controller) {
            print(controller.loadMoreItems.value.length);
            return ListView.builder(
                controller: scrollController,
                itemCount: controller.loadMoreItems.value.length + 1,
                itemBuilder: (ctx, index) {
                  if (index == controller.loadMoreItems.value.length) {
                    if (controller.loadMoreItems.value.length >=
                        (controller.pagination.value.limit ?? 10) ||
                        controller.loadMoreItems.value.length == 0) {
                      return WidgetLoading(
                        notData: controller.lastItem,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                  if (controller.lastItem == false &&
                      controller.loadMoreItems.value.length == 0) {
                    return WidgetLoading();
                  }

                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: List.generate(
                          controller
                              .loadMoreItems.value[index].results
                              ?.length ??
                              0, (index2) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5),
                          child: ItemTinTucComponent(
                            image: controller.loadMoreItems.value[index]
                                .results?[index2].imageUrl,
                            onTap: () {
                              print(
                                  "IdentifiedRecentlyScreen----- ${jsonEncode(
                                      controller.loadMoreItems
                                          .value[index].results?[index2]
                                          .imageUrl)}");
                              Get.to(DetailResultPage(
                                diseaseModel: controller.loadMoreItems
                                    .value[index].results?[index2]
                                    .disease,
                              ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  controller.loadMoreItems.value[index]
                                      .results?[index2].disease?.name ??
                                      "Chưa được cập nhật",
                                  style: StyleConst.boldStyle(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetIconText(
                                  iconAsset: AssetsConst.iconTime,
                                  text:
                                  "${controller.loadMoreItems.value[index]
                                      .createdAt ?? ""}",
                                  size: 12,
                                  style:
                                  StyleConst.regularStyle(
                                      fontSize: miniSize),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
