import 'package:flutter/material.dart';

import 'color-constant.dart';
import 'size-constant.dart';

String fontMedium = "Font-Medium";
String fontBold = "Font-Bold";
String fontRegular = "Font-Regular";

class StyleConst {
  static TextStyle boldStyle(
          {Color? color,
          double? fontSize,
          double? height,
          FontWeight? fontWeight,
          FontStyle? fontStyle,
          TextDecoration? textDecoration,
          String? package}) =>
      TextStyle(
          color: color ?? ColorConst.textPrimary,
          fontFamily: fontBold,
          package: package,
          height: height ?? 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontStyle: fontStyle ?? FontStyle.normal,
          fontSize: fontSize ?? defaultSize,
          decoration: textDecoration ?? TextDecoration.none);

  static TextStyle italicStyle(
          {Color? color,
          double? fontSize,
          double? height,
          FontWeight? fontWeight,
          FontStyle? fontStyle,
          TextDecoration? textDecoration,
          String? package}) =>
      TextStyle(
          color: color ?? ColorConst.textPrimary,
          fontFamily: fontBold,
          package: package,
          height: height ?? 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontStyle: fontStyle ?? FontStyle.italic,
          fontSize: fontSize ?? defaultSize,
          decoration: textDecoration ?? TextDecoration.none);

  static TextStyle regularStyle(
          {Color? color,
          double? fontSize,
          double? height,
          FontWeight? fontWeight,
          FontStyle? fontStyle,
          TextDecoration? textDecoration,
          String? package}) =>
      TextStyle(
          color: color ?? ColorConst.textPrimary,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? defaultSize,
          fontStyle: fontStyle ?? FontStyle.normal,
          fontFamily: fontRegular,
          package: package,
          height: height ?? 1.1,
          decoration: textDecoration ?? TextDecoration.none);

  static TextStyle mediumStyle(
          {Color? color,
          double? fontSize,
          double? height,
          FontWeight? fontWeight,
          FontStyle? fontStyle,
          TextDecoration? textDecoration,
          String? package}) =>
      TextStyle(
          color: color ?? ColorConst.textPrimary,
          fontStyle: fontStyle ?? FontStyle.normal,
          fontSize: fontSize ?? defaultSize,
          fontFamily: fontMedium,
          height: height ?? 1.1,
          fontWeight: fontWeight ?? FontWeight.normal,
          package: package,
          decoration: textDecoration ?? TextDecoration.none);
}
