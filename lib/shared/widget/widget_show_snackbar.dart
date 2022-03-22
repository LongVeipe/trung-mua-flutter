import '../../export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
    {required String title,
    required String body,
    Color? color,
    Color? backgroundColor}) {
  Get.snackbar(
    title,
    body,
    snackPosition: SnackPosition.TOP,
    backgroundColor:
        (backgroundColor?.withOpacity(.8)) ?? ColorConst.secondaryColor.withOpacity(.8),
    colorText: color ?? ColorConst.white,
    duration: Duration(seconds: 4),
  );
}
