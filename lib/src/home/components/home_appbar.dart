import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/user/user_model.dart';
import 'package:viettel_app/shared/widget/widget-circle-avatar.dart';
import 'package:viettel_app/src/information/information_user_page.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login_requirement/login_requirement_page.dart';
import 'package:viettel_app/src/notification/notification_page.dart';
import 'package:viettel_app/src/seach/search_page.dart';

import '../../../export.dart';

class HomeAppbar extends StatelessWidget {
  final User userCurrent;

  HomeAppbar({Key? key, required this.userCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          WidgetCircleAvatar(
            height: 58,
            width: 58,
            url: userCurrent.avatar,
            onTap: () {
              if (userCurrent.id == null) {
                Get.to(() => LoginRequirementPage());
              } else
                Get.to(InformationUserPage());
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          userCurrent.name != null ? "Xin chào\n" : "Đăng nhập",
                      style: StyleConst.mediumStyle(height: 1.3)),
                  TextSpan(
                      text: userCurrent.name ?? "",
                      style: StyleConst.boldStyle(
                          fontSize: titleSize, height: 1.3)),
                ])),
          )),
          GestureDetector(
            onTap: () {
              Get.to(SearchPage());
            },
            child: Image(
              image: AssetImage(
                AssetsConst.iconSearch,
              ),
              width: 20,
            ),
          ),
          userCurrent.id != null
              ? Container(
                  margin: EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(NotificationPage());
                    },
                    child: Image(
                      image: AssetImage(
                        AssetsConst.iconNotification,
                      ),
                      width: 20,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
