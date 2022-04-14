import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/models/user/plant_model.dart';
import 'package:viettel_app/models/user/user_model.dart';
import 'package:viettel_app/repositories/auth_repo.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/firebase/firebase_auth.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/helper/information_device.dart';
import 'package:viettel_app/shared/helper/location.dart';
import 'package:viettel_app/src/camera_search/controllers/consumable_store.dart';
import 'package:viettel_app/src/home/nagivator_bottom_page.dart';
import 'package:viettel_app/src/information/flash_screen_page.dart';
import 'package:viettel_app/src/information/flash_screen_success_page.dart';
import 'package:viettel_app/src/information/information_personal_page.dart';

import '../../../export.dart';

class AuthController extends GetxController {
  Position? position;

  User userCurrent = User();
  List<PlantModel> listPlant = [];

  AuthController() {
    init();
  }

  init() async {
    getInfoDevice();
    if(listPlant.length == 0)
      getPlants();
  }

  isLogged(){
    return userCurrent.id != null;
  }



  login({
    required String phone,
    required String code,
    required BuildContext context,
  }) async {
    WaitingDialog.show(context);
    ConfigFirebaseAuth.intent.validateCode(code, (result) async {
      print(result.status);
      if (result.status == AuthStatus.Verified) {
        UserModel data =
            await authRepository.loginRepo(idToken: result.token ?? "");
        if (data.token != null && data.token!.isNotEmpty) {
          await initDataAfterLoggedIn(data, phone);
          WaitingDialog.turnOff();

          if ((data.user?.name ?? "").isNotEmpty) {
            await SPref.instance.set(AppKey.staffId, data.user?.id ?? "");
            Get.offAll(NavigatorBottomPage());
          } else {
            // print("${userCurrent.id}");
            // Get.offAll(FlashScreenPage());
            Get.offAll(InformationPersonalPage(
              checkFirst: true,
            ));
          }
        } else {
          WaitingDialog.turnOff();
          showSnackBar(
              title: "Thông báo",
              body: "Xác thực không thành công vui lòng thử lại sau.");
        }
      } else {
        WaitingDialog.turnOff();
        showSnackBar(
            title: "Thông báo",
            body: "Mã OTP không chính xác",
            backgroundColor: Colors.red);
      }
    });
  }

  userUpdateMe(InformationPersonalParam param, bool nextPage) async {
    var data = await authRepository.userUpdateMe(
        name: param.name.text,
        phone: param.numberPhone.text,
        address: param.address.text,
        province: param.province,
        district: param.district,
        area: param.area.text.isEmpty
            ? null
            : param.area.text.replaceAll(",", "."),
        plantId: param.plantId,
        avatar: param.avatar,
        ward: param.ward,
        position: position);
    if (data.name!.isNotEmpty) {
      await SPref.instance.set(AppKey.staffId, data.id ?? "");
      userCurrent = data;
      if (nextPage == true) {
        Get.to(FlashScreenSuccessPage());
      } else {
        Get.back();
        showSnackBar(title: "Thông báo", body: "Cập nhật thành công");
      }
      update();
    }
  }

  userGetMe() async {
    userCurrent = await authRepository.userGetMe();
    update();
  }

  getPlants() async {
    listPlant = await categoryRepository.getPlants();
    update();
  }

  initDataAfterLoggedIn(UserModel data, String phone) async {
    await SPref.instance.set(AppKey.xToken, data.token ?? "");
    await SPref.instance.set(AppKey.phoneNumber, phone);
    await userGetMe();
    if(listPlant.length == 0)
      await getPlants();
  }
}
