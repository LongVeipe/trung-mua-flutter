import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viettel_app/export.dart';

class ConfigFirebaseAuth {
  FirebaseAuth auth = FirebaseAuth.instance;

  static String _verificationId = "";
  static int? _resendToken = 1;

  int timeOutSeconds = 120;

  static ConfigFirebaseAuth get intent => ConfigFirebaseAuth();

  verifyPhoneNumber(String phone, Function(FirebaseAuthResult) callBack) async {
    print(phone);
    if (phone.startsWith('0')) phone = phone.substring(1);
    await auth.verifyPhoneNumber(
        phoneNumber: '+84' + phone,
        timeout: Duration(seconds: timeOutSeconds),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          // final authResult =
          //     await _auth.signInWithCredential(phoneAuthCredential);
          print("verificationCompleted-----${phoneAuthCredential.smsCode}");
        },
        verificationFailed: (FirebaseAuthException authException) {
          switch (authException.code) {
            case "invalid-phone-number":
              callBack.call(FirebaseAuthResult(
                  status: AuthStatus.Fail, msg: authException.message));
              showSnackBar(
                  title: "Lỗi",
                  body: "Số điện thoại không chính xác",
                  backgroundColor: ColorConst.red);
              break;
            case "quotaExceeded":
              callBack.call(FirebaseAuthResult(
                  status: AuthStatus.QuotaExceeded,
                  msg: authException.message));
              break;
            default:
              callBack.call(FirebaseAuthResult(
                  status: AuthStatus.Fail, msg: authException.message));
          }
          print(authException.message);

          // Future.delayed(Duration(seconds: 5), () {
          //   showSnackBar(title: "Error", body: authException.message??"",backgroundColor: Colors.red);
          // });
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          _resendToken = resendToken;
          callBack.call(FirebaseAuthResult(status: AuthStatus.CodeSent));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout-----");
        },
        forceResendingToken: _resendToken ?? 1);
  }

  validateCode(String code, Function(FirebaseAuthResult) callBack) async {
    print(code);
    print("_verificationId----$_verificationId");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code);
    UserCredential? authRes =
        await auth.signInWithCredential(credential).catchError((e) {
      print("validateCode----${e.toString()}");
      callBack
          .call(FirebaseAuthResult(status: AuthStatus.Fail, msg: e.toString()));
    });
    if (authRes == null) {
      callBack.call(FirebaseAuthResult(
          status: AuthStatus.Fail, msg: 'Không thể đăng nhập. Mã lỗi: 0001'));
    } else {
      final String token = await authRes.user?.getIdToken() ?? "";
      print('ConfigFirebaseAuth-----Token: $token');
      callBack.call(FirebaseAuthResult(
          status: AuthStatus.Verified, token: token, user: authRes.user));
    }
  }
}

enum AuthStatus { Verified, Timeout, CodeSent, Fail, QuotaExceeded }

class FirebaseAuthResult {
  AuthStatus? status;
  String? token;
  String? msg;
  User? user;

  FirebaseAuthResult({this.status, this.token, this.msg, this.user});
}
