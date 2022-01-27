import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/repositories/scan_disease_repo.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/helper/image_helper.dart';
import 'package:viettel_app/src/camera_search/components/view_check_type_ai.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';

class CameraSearchController extends GetxController {
  DiseaseScanModel? scanDiseaseCurrent;
  List<String> imageNetWorks = [];
  String type = "Worm"; // Disease or Worm
  String typePlant = ""; // Plant

  CameraSearchController() {
    scanDiseaseCurrent = null;
    var result = Get.find<AuthController>().listPlant;
    typePlant = removeUnicode(result.first.name??"");
  }

  scanDisease(
      {required List<String> images, required BuildContext context}) async {
    imageNetWorks = [];
    WaitingDialog.showTimer(context, message: "AI đang nhận diện", count: 30);
    try {
      for (var item in images) {
        await updateImage(item, onUpdateImage: (value) {
          print("gallery - $value");
          if (value != null) {
            imageNetWorks.add(value);
          }
        });
      }
      scanDiseaseCurrent = await scanDiseaseRepository.scanDisease(
          imageNetWorks, type:type, treeType: typePlant);
    } catch (error) {
      print("scanDisease---$error");
    }
    WaitingDialog.turnOffTime();
    update();
  }
}
