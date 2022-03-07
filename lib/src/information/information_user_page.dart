import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/user/user_model.dart';
import 'package:viettel_app/services/firebase/firebase_auth.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/widget/widget-circle-avatar.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget-version.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/feedback/feedback_page.dart';
import 'package:viettel_app/src/home/controllers/home_controller.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login/login_page.dart';

import '../../export.dart';
import 'information_crops_page.dart';
import 'information_personal_page.dart';

class InformationUserPage extends StatefulWidget {
  const InformationUserPage({Key? key}) : super(key: key);

  @override
  _InformationUserPageState createState() => _InformationUserPageState();
}

class _InformationUserPageState extends State<InformationUserPage> {
  List<ModelInformationUser> listModel = [];

  AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listModel.add(ModelInformationUser(
        title: "Thông tin tài khoản",
        assetsIcon: AssetsConst.iconInformationProfile,
        functionClick: () {
          Get.to(InformationPersonalPage(
            checkFirst: false,
          ));
        }));
    listModel.add(ModelInformationUser(
        title: "Thông tin cây trồng",
        assetsIcon: AssetsConst.iconInformationCrops,
        functionClick: () {
          InformationPersonalParam param = InformationPersonalParam();
          param.avatar = _authController.userCurrent.avatar ?? "";
          param.plantId = _authController.userCurrent.plant?.id ?? "";
          param.area.text = _authController.userCurrent.area.toString();
          param.numberPhone.text = _authController.userCurrent.phone ?? "";
          param.name.text = _authController.userCurrent.name ?? "";
          param.address.text =
              _authController.userCurrent.place?.fullAddress ?? "";
          if (_authController.userCurrent.place != null) {
            if (_authController.userCurrent.place!.provinceId!.isNotEmpty) {
              param.province = FormComboBox(
                  title: _authController.userCurrent.place?.province ?? "",
                  key: _authController.userCurrent.place?.provinceId ?? "",
                  id: _authController.userCurrent.place?.provinceId ?? "");
            }
            if (_authController.userCurrent.place!.districtId!.isNotEmpty) {
              param.district = FormComboBox(
                  title: _authController.userCurrent.place?.district ?? "",
                  key: _authController.userCurrent.place?.districtId ?? "",
                  id: _authController.userCurrent.place?.districtId ?? "");
            }
            if (_authController.userCurrent.place!.wardId!.isNotEmpty) {
              param.ward = FormComboBox(
                  title: _authController.userCurrent.place?.ward ?? "",
                  key: _authController.userCurrent.place?.wardId ?? "",
                  id: _authController.userCurrent.place?.wardId ?? "");
            }
          }

          Get.to(InformationCropsPage(
            informationPersonalParam: param,
          ));
        }));
    // listModel.add(ModelInformationUser(
    //     title: "Điều chỉnh cỡ chữ",
    //     assetsIcon: AssetsConst.iconInformationSizeText));
    // listModel.add(ModelInformationUser(
    //     title: "Tải dự liệu ngoại tuyến qua 3G/4G",
    //     valueCheck: false,
    //     assetsIcon: AssetsConst.iconInformationDownload));
    listModel.add(ModelInformationUser(
        title: "Nhận thông báo từ ứng dụng",
        valueCheck: true,
        assetsIcon: AssetsConst.iconNotificationNone));
    // listModel.add(ModelInformationUser(
    //     title: "Thông tin",
    //     assetsIcon: AssetsConst.iconInformationHelp,functionClick: (){
    //       Get.to(InformationAppPage());
    // }));
    listModel.add(ModelInformationUser(
        title: "Góp ý",
        assetsIcon: AssetsConst.iconInformationFeedback,
        functionClick: () {
          Get.to(FeedBackPage());
        }));
    listModel.add(ModelInformationUser(
        title: "Đăng xuất",
        assetsIcon: AssetsConst.iconInformationLogout,
        functionClick: () {
          ConfigFirebaseAuth.intent.auth.signOut();
          SPref.instance.clear();
          _authController.userCurrent = User();
          Get.offAll(LoginPage());
        })
      ..turnOffIconEnd = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConst.white,
        child: Column(
          children: [
            WidgetAppbar(
              title: "Tài khoản",
              turnOffSearch: true,
            ),
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  child: Row(
                    children: [
                      GetBuilder<AuthController>(builder: (controller) {
                        return WidgetCircleAvatar(
                          height: 58,
                          width: 58,
                          url: _authController.userCurrent.avatar,
                        );
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      GetBuilder<AuthController>(
                        builder: (controller) {
                          return Expanded(
                            child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Xin chào\n",
                                      style:
                                          StyleConst.mediumStyle(height: 1.3)),
                                  TextSpan(
                                      text: "${controller.userCurrent.name}",
                                      style: StyleConst.boldStyle(height: 1.3)),
                                ])),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(listModel.length,
                      (index) => itemWidget(data: listModel[index])),
                ),
                Spacer(),
                AppVersion(),
                Spacer(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget itemWidget({required ModelInformationUser data}) {
    return GestureDetector(
      onTap: () {
        data.functionClick?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        decoration: BoxDecoration(
            border: Border(
          // bottom: BorderSide(color: ColorConst.borderInputColor),
          top: BorderSide(color: ColorConst.borderInputColor),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  AssetImage(data.assetsIcon),
                  size: 20,
                  color: ColorConst.primaryColor,
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "${data.title}",
                  style: StyleConst.regularStyle(),
                )
              ],
            ),
            Visibility(
                visible: !data.turnOffIconEnd,
                child: data.valueCheck == null
                    ? Icon(
                        Icons.navigate_next,
                        color: ColorConst.primaryColor,
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            data.valueCheck = !(data.valueCheck ?? false);
                          });
                        },
                        child: Image(
                          image: AssetImage(data.valueCheck == false
                              ? AssetsConst.iconInformationSwipeFalse
                              : AssetsConst.iconInformationSwipeTrue),
                          width: 37,
                          height: 20,
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}

class ModelInformationUser {
  final String title;
  final String assetsIcon;
  bool? valueCheck;
  bool turnOffIconEnd = false;
  Function? functionClick;

  ModelInformationUser(
      {required this.title,
      required this.assetsIcon,
      this.valueCheck,
      this.functionClick});
}
