import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viettel_app/services/firebase/firebase_auth.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget_otp_input.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';

import '../../export.dart';


final int OTP_LENGTH = 6;
class LoginOTPPage extends StatefulWidget {
  final String phone;

  const LoginOTPPage({Key? key, required this.phone}) : super(key: key);

  @override
  _LoginOTPPageState createState() => _LoginOTPPageState();
}

class _LoginOTPPageState extends State<LoginOTPPage> {
  String stringOTP = "";
  Timer? _timer;
  int _start =0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      startTimer();
    });
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                ),
                Text(
                  "XÁC NHẬN",
                  style: StyleConst.boldStyle(fontSize: titleSize),
                ),
                Text(
                  "Vui lòng nhập mã OTP được gửi đến số ${widget.phone}",
                  style: StyleConst.regularStyle(height: 1.5),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 43, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mã OTP",
                        style: StyleConst.boldStyle(fontSize: titleSize),
                      ),
                      // widgetOTP(),

                      SizedBox(
                        height: 24,
                      ),

                      WidgetOTPInput(
                        length: OTP_LENGTH,
                        appContext: context,
                        onChange: (String value) {
                          setState(() {
                            stringOTP = value;
                          });
                        },
                        onSubmit: (String value) {
                          // Get.find<AuthController>()
                          //     .login(phone: widget.phone,code: value);
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 55, right: 64 - 16, left: 64 - 16, bottom: 34),
                        child: WidgetButton(
                          text: "Xác nhận",
                          isEnable: stringOTP.length == OTP_LENGTH,
                          textColor: Colors.white,
                          backgroundColor: stringOTP.length == OTP_LENGTH ? ColorConst.primaryColor : ColorConst.secondaryColor,
                          radius: 100,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await Get.find<AuthController>().login(
                                phone: widget.phone,
                                code: stringOTP,
                                context: context);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              if(_start==0){
                                WaitingDialog.show(context);
                                await ConfigFirebaseAuth.intent.verifyPhoneNumber(
                                    widget.phone, (result) {
                                  WaitingDialog.turnOff();
                                  if (result.status == AuthStatus.CodeSent) {
                                    showSnackBar(
                                        title: "Thông báo",
                                        body: "Gửi mã lại thành công.");
                                    startTimer();
                                  } else {
                                    showSnackBar(
                                        title: "Thông báo",
                                        body: "Gửi mã lại không thành công.",backgroundColor: Colors.red);
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Gửi lại OTP ",
                              style: StyleConst.regularStyle(
                                color: _start > 0
                                    ? Colors.grey
                                    : ColorConst.primaryColor,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            "Sau ${_start}s",
                            style: StyleConst.regularStyle(),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                // SizedBox(height: 70,),
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

  void startTimer() {
    _start = ConfigFirebaseAuth.intent.timeOutSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
