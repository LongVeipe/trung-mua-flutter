import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import '../../export.dart';
import 'information_personal_page.dart';

class InformationCropsPage extends StatefulWidget {
  final InformationPersonalParam informationPersonalParam;
  final bool checkFirst;

  const InformationCropsPage(
      {Key? key,
      required this.informationPersonalParam,
      this.checkFirst = false})
      : super(key: key);

  @override
  _InformationCropsPageState createState() => _InformationCropsPageState();
}

class _InformationCropsPageState extends State<InformationCropsPage> {
  bool enableEdit = false;
  AuthController _authController = Get.find<AuthController>();
  List<FormComboBox> listPlantView = [];

  FormComboBox? plantSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController.getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            WidgetAppbar(
              title: "Thông tin cây trồng",
              turnOffNotification: true,
              turnOffSearch: true,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                color: ColorConst.backgroundColor,
                width: MediaQuery.of(context).size.width,
                child: GetBuilder<AuthController>(
                  builder: (controller) {
                    if (controller.listPlant.length > 0) {
                      listPlantView =
                          List<FormComboBox>.from(controller.listPlant.map((d) {
                        if (d.id == widget.informationPersonalParam.plantId) {
                          plantSelected = FormComboBox(
                              title: d.name ?? "", key: d.id, id: d.id ?? "");
                        }
                        return FormComboBox(
                            title: d.name ?? "", key: d.id, id: d.id ?? "");
                      }));
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Loại cây trồng: ",
                            style: StyleConst.boldStyle(fontSize: titleSize),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 24),
                            child: WidgetComboBox(
                                listData: listPlantView,
                                turnOffValidate: true,
                                itemSelected: plantSelected,
                                hintText: "Chọn loại cây trồng",
                                onSelected: (value) {
                                  plantSelected = value;
                                }),
                          ),
                          Text(
                            "Diện tích (ha): ",
                            style: StyleConst.boldStyle(fontSize: titleSize),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 24),
                            child: WidgetTextField(
                              controller: widget.informationPersonalParam.area,
                              turnOffValidate: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              hintText: "Nhập diện tích",
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 64,
                  right: 64,
                  top: 16,
                  bottom: 10 + MediaQuery.of(context).padding.bottom),
              child: widget.checkFirst == true
                  ? WidgetButton(
                      text: "Tiếp tục",
                      radius: 100,
                      textColor: Colors.white,
                      onTap: () async {
                        widget.informationPersonalParam.plantId =
                            plantSelected?.id ?? "";
                        await _authController.userUpdateMe(
                            widget.informationPersonalParam, true);
                      },
                    )
                  : WidgetButton(
                      text: "Lưu",
                      radius: 100,
                      textColor: Colors.white,
                      onTap: () async {
                        widget.informationPersonalParam.plantId =
                            plantSelected?.id ?? "";
                        await _authController.userUpdateMe(
                            widget.informationPersonalParam, false);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
