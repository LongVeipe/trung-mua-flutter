import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/repositories/feedback_repo.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';

import '../../export.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  bool turnOffValidate = true;
  FeedBackParam param = FeedBackParam();

  final AuthController _authController=Get.find();

  List<FormComboBox> listPlants=[];
  FormComboBox? itemPlant;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPlants=_authController.listPlant.map((e) => FormComboBox(title: e.name,id: e.id)).toList();
    itemPlant=listPlants.first;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            WidgetAppbar(
              title: "Góp ý",
              turnOffSearch: true,
            ),
            Expanded(
              child: Container(
                color: ColorConst.backgroundColor,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tiêu đề",
                        style: StyleConst.boldStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 31, top: 14),
                        child: WidgetTextField(
                          turnOffValidate: turnOffValidate,
                          hintText: "Nhập tiêu đề",
                          controller: param.title,
                        ),
                      ),

                      Text(
                        "Loại cây trồng",
                        style: StyleConst.boldStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 31, top: 14),
                        child: WidgetComboBox(
                          turnOffValidate: turnOffValidate,
                          hintText: "Chọn loại cây trồng",
                          listData:listPlants,
                          itemSelected: itemPlant,
                          onSelected: (value) {
                           setState(() {
                             itemPlant= value;
                           });
                          },
                        ),
                      ),

                      Text(
                        "Nội dung",
                        style: StyleConst.boldStyle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 31, top: 14),
                        child: WidgetTextField(
                          turnOffValidate: turnOffValidate,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          hintText: "Nhập nội dung góp ý",
                          keyboardType: TextInputType.multiline,
                          maxLine: 10,
                          minLine: 10,
                          controller: param.body,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: WidgetButton(
                          text: "Gửi",
                          textColor: ColorConst.primaryColor,
                          backgroundColor: Colors.white,
                          radiusColor: ColorConst.primaryColor,
                          radius: 100,
                          onTap: () async {
                            await feedBackRepository.createFeedback(
                                title: "[${itemPlant?.title??""}]${param.title.text}",
                                message: param.body.text).then((value) {
                              if (value != null) {
                                Get.back();
                                showSnackBar(
                                    title: "Thông báo",
                                    body: "Gửi góp ý thành công.");
                              } else {
                                showSnackBar(
                                    title: "Thông báo",
                                    body:
                                    "Gửi góp ý không thành công, vui lòng thử lại sau.");
                              }
                            });

                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedBackParam {
  late TextEditingController title;
  late TextEditingController body;

  FeedBackParam() {
    this.title = TextEditingController();
    this.body = TextEditingController();
  }
}
