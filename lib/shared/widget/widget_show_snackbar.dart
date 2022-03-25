import 'package:graphql_flutter/graphql_flutter.dart';

import '../../export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
    {required String title,
    required String body,
    Color? color,
    Color? backgroundColor,
    int? duration}) {
  Get.snackbar(
    title,
    body,
    snackPosition: SnackPosition.TOP,
    backgroundColor: (backgroundColor?.withOpacity(.8)) ??
        ColorConst.secondaryColor.withOpacity(.8),
    colorText: color ?? ColorConst.white,
    duration: Duration(seconds: duration ?? 4),
  );
}

void showBottomSnackbar({
  required BuildContext context,
  required String content,
  Color? backgroundColor,
  int? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    duration: Duration(seconds: duration ?? 2),
    backgroundColor: backgroundColor?? ColorConst.secondaryColor.withOpacity(0.8),
  ));
}
