import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/export.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/login/login_page.dart';

class LoginRequirementPage extends StatelessWidget {
  const LoginRequirementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yêu cầu đăng nhập"), backgroundColor: ColorConst.primaryBackgroundLight, foregroundColor: ColorConst.textPrimary,),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16,),
                Image.asset(
                  AssetsConst.loginRequirement,
                  fit: BoxFit.fitWidth,
                ),
                Text("KIẾN TẠO",
                    style: StyleConst.boldStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: titleSize * 2,
                        color: ColorConst.primaryColor)),
                SizedBox(
                  height: 16,
                ),
                Text("KHÔNG GIAN PHÁT TRIỂN\nNÔNG NGHIỆP MỚI",
                    textAlign: TextAlign.center,
                    style: StyleConst.regularStyle(
                        height: 1.3,
                        fontWeight: FontWeight.w200,
                        fontSize: defaultSize,
                        color: ColorConst.textPrimary)),
                SizedBox(
                  height: 48,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            "Đăng nhập hoặc tạo tài khoản nhanh\nđể sử dụng các tính năng của ",
                        style: StyleConst.regularStyle(fontSize: miniSize),
                        children: [
                          TextSpan(
                              text: "Trúng Mùa",
                              style: StyleConst.regularStyle(
                                color: ColorConst.primaryColor,
                                fontSize: miniSize,
                              ))
                        ])),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WidgetButton(
                    text: "Đăng nhập",
                    textColor: ColorConst.textPrimaryDark,
                    onTap: (){
                      Get.to(LoginPage());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WidgetButton(
                    text: "Tạo tài khoản mới",
                    backgroundColor: ColorConst.secondaryBackgroundLight,
                    onTap: () {
                      Get.to(LoginPage(isLogin: false,));
                    },
                  ),
                ),
                SizedBox(
                  height: 48,
                )
              ],
            )),
      ),
    );
  }
}
