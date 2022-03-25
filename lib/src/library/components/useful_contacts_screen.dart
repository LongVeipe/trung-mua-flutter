import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget-nodata.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/information/controllers/information_contoller.dart';
import 'package:viettel_app/src/library/controllers/search_bvtv_controller.dart';
import 'package:viettel_app/src/seach/components/search_none_componet.dart';

import '../../../export.dart';

class UsefulPhonebook extends StatefulWidget {
  UsefulPhonebook({Key? key}) : super(key: key);

  @override
  _UsefulPhonebookState createState() => _UsefulPhonebookState();
}

class _UsefulPhonebookState extends State<UsefulPhonebook> {
  SearchBVTVController _searchBVTVController = Get.put(SearchBVTVController());

  FormComboBox? itemProvince;
  bool showResult = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(InformationController());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorConst.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(bottom: 109, top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Tỉnh/thành phố",
                  style: StyleConst.boldStyle(),
                ),
              ),
              GetBuilder<InformationController>(
                builder: (controller) => WidgetComboBox(
                  turnOffValidate: true,
                  hintText: "Vui lòng chọn tỉnh thành",
                  listData: controller.listDataProvince,
                  itemSelected: itemProvince,
                  onSelected: (value) {
                    setState(() {
                      showResult = false;
                      itemProvince = value;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 35),
                child: WidgetButton(
                  text: "Tìm kiếm",
                  textColor: Colors.white,
                  paddingBtnHeight: 12,
                  radius: 25,
                  onTap: () async {
                    if (itemProvince != null) {
                      await _searchBVTVController.searchBVTV(
                          provinceId: itemProvince?.id ?? "", context: context);
                      setState(() {
                        showResult = true;
                      });
                    }
                  },
                ),
              ),
              Visibility(
                visible: showResult == true,
                child: GetBuilder<SearchBVTVController>(builder: (controller) {
                  return Column(
                      children: List.generate(
                          controller.loadMoreItems.value.length + 1, (index) {
                    if (index == controller.loadMoreItems.value.length) {
                      if (controller.loadMoreItems.value.length >=
                          (controller.pagination.value.limit ?? 10) ||
                          controller.loadMoreItems.value.length == 0) {
                        if (controller.lastItem == true) {
                          return SearchNoneComponent();
                        }
                        return WidgetLoading(
                          notData: controller.lastItem,
                        );
                      } else {
                        print("controller.lastItem---- ${controller.lastItem}");
                        return SizedBox.shrink();
                      }
                    }
                    if (controller.lastItem == false &&
                        controller.loadMoreItems.value.length == 0) {
                      return WidgetLoading();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 1,
                          color: ColorConst.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "${controller.loadMoreItems.value[index].name ?? ""}",
                            style: StyleConst.regularStyle(fontSize: titleSize),
                          ),
                        ),
                        WidgetIconText(
                          icon: Icon(
                            Icons.location_pin,
                            color: ColorConst.primaryColor,
                            size: 14,
                          ),
                          text: "Địa chỉ",
                          style: StyleConst.boldStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${controller.loadMoreItems.value[index].place?.fullAddress ?? ""}",
                          style: StyleConst.regularStyle(height: 1.3),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        WidgetIconText(
                          icon: Icon(
                            Icons.phone,
                            color: ColorConst.primaryColor,
                            size: 14,
                          ),
                          text: "Điện thoại",
                          style: StyleConst.boldStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.loadMoreItems.value[index].phone ?? "",
                          style: StyleConst.regularStyle(height: 1.3),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // // WidgetIconText(
                        // //   icon: Icon(
                        // //     Icons.email_rounded,
                        // //     color: ColorConst.primaryColor,
                        // //     size: 14,
                        // //   ),
                        // //   text: "Email",
                        // //   style: StyleConst.boldStyle(),
                        // // ),
                        // // SizedBox(
                        // //   height: 5,
                        // // ),
                        // Text(
                        //   "hanoi.bvtv@gamil.com",
                        //   style: StyleConst.regularStyle(height: 1.3),
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // WidgetIconText(
                        //   iconAsset: AssetsConst.iconFax,
                        //   size: 12,
                        //   text: "Fax",
                        //   style: StyleConst.boldStyle(),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   "024.733.5599",
                        //   style: StyleConst.regularStyle(height: 1.3),
                        // ),
                      ],
                    );
                  }));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
