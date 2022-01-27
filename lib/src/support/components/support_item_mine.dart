import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/support/message_model.dart';
import 'package:viettel_app/shared/widget/widget-circle-avatar.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';

class SupportItemMine extends StatelessWidget {
  final MessageModel data;
  const SupportItemMine({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    EdgeInsetsGeometry paddingAll =
    const EdgeInsets.symmetric(vertical: 16, horizontal: 16);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 33, top: 20),
                width: MediaQuery.of(context).size.width - 33 - 56,
                padding: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //     color: ColorConst.backgroundColor,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(100),
                //       topRight: Radius.circular(0),
                //       bottomRight: Radius.circular(100),
                //       bottomLeft: Radius.circular(100),
                //     )),
                child: Column(
                  children: [
                    Container(
                        padding: paddingAll,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorConst.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)
                          ),
                        ),
                        child: Text(
                          data.content??"",
                          style: StyleConst.regularStyle(color: Colors.white),
                        )),
                    // Container(
                    //     padding: paddingAll,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         color: ColorConst.primaryColor,
                    //         border: Border(
                    //             bottom: BorderSide(
                    //                 color: ColorConst.backgroundColor))),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Expanded(
                    //           child: Text(
                    //             "Bệnh rầu nâu là gì?",
                    //             style: StyleConst.boldStyle(color: Colors.white),
                    //           ),
                    //         ),
                    //         ImageIcon(
                    //           AssetImage(AssetsConst.iconSupportArrowRoundBack),
                    //           color: Colors.white,
                    //           size: 13,
                    //         ),
                    //       ],
                    //     )),
                    // Container(
                    //     padding: paddingAll,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         color: ColorConst.primaryColor,
                    //         borderRadius: BorderRadius.only(
                    //           bottomRight: Radius.circular(50),
                    //           bottomLeft: Radius.circular(50),
                    //         )),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Expanded(
                    //           child: Text(
                    //             "Triệu chứng bệnh trên cổ bông?",
                    //             style: StyleConst.boldStyle(color: Colors.white),
                    //           ),
                    //         ),
                    //         ImageIcon(
                    //           AssetImage(AssetsConst.iconSupportArrowRoundBack),
                    //           color: Colors.white,
                    //           size: 13,
                    //         ),
                    //       ],
                    //     )),
                  ],
                ),
              ),
              SizedBox(
                width: 56,
                height: 56,
              )
            ],
          ),
          Positioned(
            right: 16,
            height: 40,
            width: 40,
            child:  WidgetCircleAvatar(
              url: Get.find<AuthController>().userCurrent.avatar,
            ),
          )
        ],
      ),
    );
  }
}
