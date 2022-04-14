import 'package:flutter/material.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/support/message_model.dart';
import 'package:viettel_app/shared/widget/widget-circle-avatar.dart';

class SupportItemTheir extends StatelessWidget {
  final MessageModel data;

  const SupportItemTheir({Key? key, required this.data}) : super(key: key);

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
              SizedBox(
                width: 56,
                height: 56,
              ),
              Container(
                margin: EdgeInsets.only(right: 33, top: 10),
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
                child: Container(
                    padding: paddingAll,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorConst.primaryBackgroundLight,
                      // border: Border(
                      //   bottom: BorderSide(
                      //     color: ColorConst.backgroundColor
                      //   )
                      // ),

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Text(
                      data.content??"",
                      style: StyleConst.regularStyle(),
                    )),
              ),
            ],
          ),
          Positioned(
            left: 16,
            height: 40,
            width: 40,
            child: Image.asset(
              AssetsConst.iconSupportLogoViettel,
              width: 40,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
