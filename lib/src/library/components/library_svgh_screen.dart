import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/camera_search/detail_result_page.dart';
import 'package:viettel_app/src/library/controllers/library_controller.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/seach/components/search_none_componet.dart';

import '../../../export.dart';

class LibraryScreen extends StatefulWidget {
  final String? tag;

  LibraryScreen({Key? key, this.tag}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  ScrollController scrollController = ScrollController();
  late LibraryController _libraryScreenState;
  AuthController authController = Get.find<AuthController>();

  List<FormComboBox> listPlants = [];
  FormComboBox? plantSelected;

  bool reload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _libraryScreenState = Get.find<LibraryController>(tag: this.widget.tag);
    } catch (error) {
      _libraryScreenState = Get.put(LibraryController(), tag: this.widget.tag);
    }
    // listPlants.add(FormComboBox(title: "Tất cả", key: "", id: null));
    authController.listPlant.forEach((e) {
      listPlants.add(FormComboBox(title: e.name ?? "", key: "", id: e.id));
    });
    plantSelected = listPlants.first;

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print(_libraryScreenState.lastItem);
        // if (_libraryScreenState.lastItem = false) {
        _libraryScreenState.loadMore();
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: GetBuilder<LibraryController>(
          tag: widget.tag,
          builder: (controller) {
            if (controller.loadMoreItems.value.length == 0 &&
                reload == true &&
                plantSelected?.id == "611c8bac6a859e247b4076b6") {
              controller.lastItem = false;
              controller.loadAll(query: QueryInput(page: 1, filter: {}));
            }

            return Container(
              color: ColorConst.backgroundColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Tổng: ${controller.total}",
                            style: StyleConst.boldStyle(),
                          ),
                        ),
                        dropFilter(
                          listData: listPlants,
                          data: plantSelected,
                          dataResult: (value) {
                            controller.lastItem = false;

                            if (value.id == null) {
                              controller.loadAll(
                                  query: QueryInput(page: 1, filter: {}));
                            } else {
                              reload = true;
                              controller.loadAll(
                                  query: QueryInput(page: 1, filter: {
                                "plantIds": ["${value.id}"]
                              }));
                            }

                            setState(() {
                              plantSelected = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  controller.lastItem == true &&
                          controller.loadMoreItems.value.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SearchNoneComponent(),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            controller: scrollController,
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).padding.bottom,
                                top: 10,
                                left: 10,
                                right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: List.generate(
                                    controller.loadMoreItems.value.length,
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(DetailResultPage(
                                            id: controller.loadMoreItems
                                                    .value[index].id ??
                                                "",
                                          ));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              30,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: WidgetImageNetWork(
                                                        url: controller
                                                                .loadMoreItems
                                                                .value[index]
                                                                .thumbnail ??
                                                            "",
                                                        width: 142,
                                                        height: 142,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 8),
                                                child: Text(
                                                  controller.loadMoreItems
                                                          .value[index].name ??
                                                      "",
                                                  style: StyleConst.boldStyle(
                                                      fontSize: titleSize),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                WidgetLoading(
                                  notData: controller.lastItem,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget dropFilter(
      {required List<FormComboBox> listData,
      required FormComboBox? data,
      required Function(FormComboBox) dataResult}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: ColorConst.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<FormComboBox>(
        value: data,
        isDense: true,
        icon: const Icon(
          Icons.filter_list_alt,
          color: ColorConst.primaryColor,
        ),
        iconSize: titleSize,
        itemHeight: kMinInteractiveDimension,
        // elevation: 16,
        style: StyleConst.regularStyle(color: ColorConst.primaryColor),
        underline: Container(
          // height: 2,
          color: Colors.transparent,
        ),
        onChanged: (FormComboBox? newValue) {
          print("${newValue?.title}");
          if (newValue != null) dataResult.call(newValue);
        },
        items:
            listData.map<DropdownMenuItem<FormComboBox>>((FormComboBox value) {
          return DropdownMenuItem<FormComboBox>(
            value: value,
            child: Text(
              value.title ?? "aaaa",
              style: StyleConst.regularStyle(color: ColorConst.primaryColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
