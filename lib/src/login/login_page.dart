import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/services/firebase/firebase_auth.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';

import '../../export.dart';
import 'login_otp_page.dart';
import 'terms_of_use.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool turnOffValidate = true;

  TextEditingController phoneNumber = TextEditingController();

  bool isChecked=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 68,
                ),
                Image.asset(
                  AssetsConst.logoFlashScreen,
                  width: 126,
                  height: 126,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Ứng dụng được phát triển bởi\n"
                    "Công ty Cổ phần Công nghệ Thông Minh MiSmart\n"
                    "Giải nhất Viet Soltions 2020 cuộc thi do Bộ Thông tin và Truyền Thông và Viettel tổ chức. ",
                    style: StyleConst.regularStyle(
                        height: 1.5, fontSize: miniSize),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                ),
                Text(
                  "ĐĂNG NHẬP",
                  style: StyleConst.boldStyle(fontSize: titleSize),
                ),
                Text(
                  "Vui lòng điền thông tin đăng nhập",
                  style: StyleConst.regularStyle(height: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Số điện thoại",
                        style: StyleConst.boldStyle(fontSize: titleSize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 31, top: 14),
                        child: WidgetTextField(
                          turnOffValidate: turnOffValidate,
                          keyboardType: TextInputType.number,
                          hintText: "Vui lòng nhập số điện thoại",
                          controller: phoneNumber,
                          onChange: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 64 - 16),
                        child: WidgetButton(
                          text: "Tiếp theo",
                          textColor: Colors.white,
                          backgroundColor: phoneNumber.text.isEmpty || isChecked==false
                              ? ColorConst.grey
                              : ColorConst.primaryColor,
                          radius: 100,
                          onTap: () async {
                            if (phoneNumber.text.isNotEmpty && isChecked==true) {
                              WaitingDialog.show(context);

                              await ConfigFirebaseAuth.intent.verifyPhoneNumber(
                                  phoneNumber.text, (result) {
                                WaitingDialog.turnOff();
                                if (result.status == AuthStatus.CodeSent) {
                                  Get.to(LoginOTPPage(
                                    phone: phoneNumber.text,
                                  ));
                                } else {
                                  // showSnackBar(
                                  //     title: "Thông báo",
                                  //     body: "Đăng nhập không thành công.",
                                  //     backgroundColor: Colors.red);
                                }
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                       activeColor:  ColorConst.primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    GestureDetector( onTap: (){
                      showNow(context);
                    },
                      child: RichText(text: TextSpan(
                         children: [
                           TextSpan(
                               text: "Tôi đồng ý với ",style: StyleConst.mediumStyle()
                           ),
                           TextSpan(
                             text: "điều khoản sử dụng",style: StyleConst.mediumStyle( color: Colors.green)
                           )
                         ]
                      )),
                    )
                  ],
                ),


                // SizedBox(height: 120),
                // Image.asset(
                //   AssetsConst.logo,
                //   width: 140,
                //   height: 40,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
