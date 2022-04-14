import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/helper/image_helper.dart';
import 'package:viettel_app/shared/widget/widget-circle-avatar.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/information/information_crops_page.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login/login_page.dart';

import '../../export.dart';
import 'controllers/information_contoller.dart';

class InformationPersonalPage extends StatefulWidget {
  bool? checkFirst;
  String? numberPhone;

  InformationPersonalPage({Key? key, this.checkFirst = false, this.numberPhone})
      : super(key: key);

  @override
  _InformationPersonalPageState createState() =>
      _InformationPersonalPageState();
}

class _InformationPersonalPageState extends State<InformationPersonalPage> {
  InformationPersonalParam param = InformationPersonalParam();
  bool turnOffValidate = true;

  late InformationController _informationController;
  late AuthController _authController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _informationController = Get.put(InformationController());
    _authController = Get.find<AuthController>();
    param.avatar = _authController.userCurrent.avatar ?? "";
    param.area.text = _authController.userCurrent.area?.toString() ?? "";
    param.plantId = _authController.userCurrent.plant?.id ?? "";
    param.numberPhone.text =
        widget.numberPhone ?? SPref.instance.get(AppKey.phoneNumber);
    param.name.text = _authController.userCurrent.name ?? "";
    param.address.text = _authController.userCurrent.place?.street ?? "";
    if (_authController.userCurrent.place != null) {
      if (_authController.userCurrent.place!.provinceId!.isNotEmpty) {
        param.province = FormComboBox(
            title: _authController.userCurrent.place?.province ?? "",
            key: _authController.userCurrent.place?.provinceId ?? "",
            id: _authController.userCurrent.place?.provinceId ?? "");
        _informationController.getDistrict(param.province?.id);
      }
      if (_authController.userCurrent.place!.districtId!.isNotEmpty) {
        param.district = FormComboBox(
            title: _authController.userCurrent.place?.district ?? "",
            key: _authController.userCurrent.place?.districtId ?? "",
            id: _authController.userCurrent.place?.districtId ?? "");
        _informationController.getWard(param.district?.id);
      }
      if (_authController.userCurrent.place!.wardId!.isNotEmpty) {
        param.ward = FormComboBox(
            title: _authController.userCurrent.place?.ward ?? "",
            key: _authController.userCurrent.place?.wardId ?? "",
            id: _authController.userCurrent.place?.wardId ?? "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: GetBuilder<InformationController>(builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                WidgetAppbar(
                  title: "Thông tin tài khoản",
                  turnOffNotification: true,
                  turnOffSearch: true,
                  widgetIcons: Visibility(
                    visible: widget.checkFirst == true,
                    child: GestureDetector(
                        onTap: () {
                          Get.offAll(LoginPage());
                        },
                        child: Icon(Icons.logout)),
                  ),
                ),
                GetBuilder<InformationController>(
                  builder: (controller) {
                    return Expanded(
                      child: Container(
                        color: ColorConst.primaryBackgroundLight,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: widget.checkFirst == false,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 27),
                                      child: Row(
                                        children: [
                                          WidgetCircleAvatar(
                                            height: 58,
                                            width: 58,
                                            url: param.avatar,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GetBuilder<AuthController>(
                                                builder: (controller) => Text(
                                                    "${controller.userCurrent.name}",
                                                    style: StyleConst.boldStyle(
                                                      fontSize: titleSize,
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showSelectImage(
                                                      context: context,
                                                      callBack: (value) {
                                                        setState(() {
                                                          param.avatar = value;
                                                        });
                                                      });
                                                },
                                                child: Text("Đổi ảnh đại diện",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            fontSize: miniSize,
                                                            color: ColorConst
                                                                .primaryColor,
                                                            height: 1.5)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Họ tên",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 31, top: 14),
                                    child: WidgetTextField(
                                      turnOffValidate: turnOffValidate,
                                      hintText: "Nhập họ tên",
                                      controller: param.name,
                                    ),
                                  ),
                                  Text(
                                    "Số điện thoại",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 31, top: 14),
                                    child: WidgetTextField(
                                      turnOffValidate: turnOffValidate,
                                      keyboardType: TextInputType.number,
                                      enabled: false,
                                      hintText: "Vui lòng nhập số điện thoại",
                                      controller: param.numberPhone,
                                    ),
                                  ),
                                  Text(
                                    "Tỉnh/thành phố",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 31, top: 14),
                                    child: WidgetComboBox(
                                      turnOffValidate: turnOffValidate,
                                      hintText: "Vui lòng chọn tỉnh thành",
                                      listData: _informationController
                                          .listDataProvince,
                                      itemSelected: param.province,
                                      onSelected: (value) {
                                        param.province = value;
                                        _informationController
                                            .getDistrict(value.id);
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Quận/ Huyện",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 31, top: 14),
                                    child: WidgetComboBox(
                                      turnOffValidate: turnOffValidate,
                                      hintText: "Vui lòng chọn Quận/ Huyện",
                                      listData: _informationController
                                          .listDataDistrict,
                                      itemSelected: param.district,
                                      onSelected: (value) {
                                        param.district = value;
                                        _informationController
                                            .getWard(value.id);
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Xã/ Phường",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 31, top: 14),
                                    child: WidgetComboBox(
                                      turnOffValidate: turnOffValidate,
                                      hintText: "Vui lòng chọn Xã/ Phường",
                                      listData:
                                          _informationController.listDataWard,
                                      itemSelected: param.ward,
                                      onSelected: (value) {
                                        param.ward = value;
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Tổ, Đội, Thôn, Số nhà (Nếu có)",
                                    style: StyleConst.boldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 91, top: 14),
                                    child: WidgetTextField(
                                      turnOffValidate: true,
                                      scrollController: scrollController,
                                      hintText: "Vui lòng nhập địa chỉ",
                                      controller: param.address,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              height: 50 +
                                  20 +
                                  MediaQuery.of(context).padding.bottom,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 64,
                                    bottom: 10 +
                                        MediaQuery.of(context).padding.bottom,
                                    right: 64,
                                    top: 10),
                                child: Center(
                                  child: (widget.checkFirst == true)
                                      ? WidgetButton(
                                          text: "Tiếp theo",
                                          textColor: Colors.white,
                                          radius: 100,
                                          onTap: () async {
                                            // submit.call();
                                            if (param.checkValidate()) {
                                              Get.to(InformationCropsPage(
                                                informationPersonalParam: param,
                                                checkFirst: true,
                                              ));
                                            } else {
                                              setState(() {
                                                turnOffValidate = false;
                                              });
                                            }
                                          },
                                        )
                                      : WidgetButton(
                                          text: "Lưu",
                                          textColor: ColorConst.white,
                                          radius: 100,
                                          onTap: () async {
                                            // submit.call();
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            if (param.checkValidate()) {
                                              await _authController
                                                  .userUpdateMe(param, false);
                                            } else {
                                              setState(() {
                                                turnOffValidate = false;
                                              });
                                            }
                                          },
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class InformationPersonalParam {
  late TextEditingController name;
  late TextEditingController numberPhone;
  FormComboBox? province;
  FormComboBox? district;
  FormComboBox? ward;
  late TextEditingController address;
  String plantId = "";
  String avatar = "";
  late TextEditingController area;

  InformationPersonalParam() {
    name = TextEditingController();
    numberPhone = TextEditingController();
    address = TextEditingController();
    area = TextEditingController();
  }

  checkValidate() {
    if (name.text.isEmpty) return false;
    if (numberPhone.text.isEmpty) return false;
    if (province == null) return false;
    if (district == null) return false;
    if (ward == null) return false;
    return true;
  }
}
