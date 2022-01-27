import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';

class WaitingDialog {
  static  BuildContext? _buildContext;

  static StreamController<int>? _streamController;

  static Timer? _timer;
  static int _start = 10;

  static void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          try{
            _streamController?.sink.add(_start--);
          }catch(error){
            print(error);
          }
        }
      },
    );
  }

  static void turnOff() {
    try {
      if(_buildContext!=null){
        Navigator.of(_buildContext!).pop();
      }
    } catch (error) {
      print("WaitingDialog----$error");
    }
  }

  static void turnOffTime() {
    try {
      _streamController?.close();
      if(_buildContext!=null){
        Navigator.of(_buildContext!).pop();
      }
      _buildContext=null;
    } catch (error) {
      print("WaitingDialog----$error");
    }
  }

  static void showTimer(BuildContext context,
      {String? message, int count = 10}) {
    _buildContext = context;
    _streamController = StreamController();
    _start = count;
    _startTimer();
    showDialog(
        context: _buildContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final spinKit = SpinKitCircle(
            color: ColorConst.primaryColor,
            size: 50.0,
          );
          return AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  spinKit,
                  StreamBuilder<int>(
                      stream: _streamController?.stream,
                      builder: (context, snapshot) {
                        return Padding(
                            padding: EdgeInsets.only(top: 18.0),
                            child: Text(
                              "$message - ${_start}s",
                              style: StyleConst.regularStyle(),
                            ));
                      })
                ],
              ));
        });
  }

  static void show(BuildContext context, {String? message}) {
    _buildContext = context;
    showDialog(
        context: _buildContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final spinkit = SpinKitCircle(
            color: ColorConst.primaryColor,
            size: 50.0,
          );
          return AlertDialog(
//          width: 300.0,
//          height: 300.0,
              backgroundColor: Colors.white,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // CircularProgressIndicator(
                  //     backgroundColor: ColorConst.backgroundColor,
                  //     value: .1,
                  //     strokeWidth: 3,
                  //     valueColor: AlwaysStoppedAnimation(
                  //       ColorConst.primaryColor,
                  //     )),
                  // CircularProgressIndicator(
                  //     valueColor: AlwaysStoppedAnimation<Color>(
                  //         Theme.of(context).primaryColor)),
                  spinkit,
                  Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        message ?? 'Đang xử lý ...',
                        style: StyleConst.regularStyle(),
                      ))
                ],
              ));
        });
  }
}
