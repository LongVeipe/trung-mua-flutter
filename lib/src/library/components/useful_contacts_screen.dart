import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget-phone-numbers-dialog.dart';
import 'package:viettel_app/shared/widget/widget_search.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/information/controllers/information_contoller.dart';
import 'package:viettel_app/src/library/controllers/search_contacts_controller.dart';
import 'package:viettel_app/src/seach/components/search_none_componet.dart';

import '../../../export.dart';

const String PHONE_TITLE = "Điện thoại";
const String EMAIL_TITLE = "Email";
class UsefulContacts extends StatefulWidget {
  UsefulContacts({Key? key}) : super(key: key);

  @override
  _UsefulContactsState createState() => _UsefulContactsState();
}

class _UsefulContactsState extends State<UsefulContacts> {
  SearchContactsController _searchContactsController =
      Get.put(SearchContactsController());

  FormComboBox? itemProvince;
  bool showResult = true;

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
                  "Danh bạ",
                  style: StyleConst.boldStyle(),
                ),
              ),
              // GetBuilder<InformationController>(
              //   builder: (controller) => WidgetComboBox(
              //     turnOffValidate: true,
              //     hintText: "Vui lòng chọn danh bạ",
              //     listData: controller.listDataProvince,
              //     itemSelected: itemProvince,
              //     onSelected: (value) {
              //       setState(() {
              //         showResult = false;
              //         itemProvince = value;
              //       });
              //     },
              //   ),
              // ),
              WidgetSearch(
                hintText: "Nhập tên liên lạc",
                controller: _searchContactsController.textEditingController,
                onSubmitted: (value) {
                  _searchContactsController.searchContacts(
                      name:
                          _searchContactsController.textEditingController.text);
                },
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 64, vertical: 35),
              //   child: WidgetButton(
              //     text: "Tìm kiếm",
              //     textColor: Colors.white,
              //     paddingBtnHeight: 12,
              //     radius: 25,
              //     onTap: () async {
              //       if (itemProvince != null) {
              //         await _searchContactsController.searchProvinces(
              //             provinceId: itemProvince?.id ?? "", context: context);
              //         setState(() {
              //           showResult = true;
              //         });
              //       }
              //     },
              //   ),
              // ),
              Visibility(
                visible: showResult,
                child:
                    GetBuilder<SearchContactsController>(builder: (controller) {
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
                        SizedBox(
                          height: 16,
                        ),
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
                        SeparateContactInfo(
                            icon: Icons.phone,
                            title: PHONE_TITLE,
                            info: controller.loadMoreItems.value[index].phone),
                        SeparateContactInfo(
                            icon: Icons.email_rounded,
                            title: EMAIL_TITLE,
                            info: controller.loadMoreItems.value[index].email),
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

  Widget SeparateContactInfo(
      {required IconData icon, required String title, String? info}) {
    if (info == null) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetIconText(
          icon: Icon(
            icon,
            color: ColorConst.primaryColor,
            size: 14,
          ),
          text: title,
          style: StyleConst.boldStyle(),
        ),
        TextButton(
          onPressed: () {
            if(title == PHONE_TITLE) {
              Get.defaultDialog(
                title: info,
                titleStyle: StyleConst.boldStyle(fontSize: titleSize),
                content: PhoneNumbersDialog(phoneNumbers: info,),
              );
            }
          },
          child: Text(
            info,
            style: StyleConst.regularStyle(
                height: 1.3, textDecoration: TextDecoration.underline),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size(0, 0),
            primary: ColorConst.primaryColor,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
