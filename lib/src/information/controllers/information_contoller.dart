import 'package:get/get.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/repositories/auth_repo.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';

import '../flash_screen_success_page.dart';
import '../information_personal_page.dart';

class InformationController extends GetxController {
  List<FormComboBox> listDataProvince = [];
  List<FormComboBox> listDataDistrict = [];
  List<FormComboBox> listDataWard = [];

  InformationController() {
    getProvince();
  }

  getProvince() async {
    listDataProvince=[];

    var data = await categoryRepository.getProvince();
    if (data.length > 0) {
      data.forEach((element) {
        listDataProvince.add(FormComboBox(
            key: element.id,
            title: element.province ?? "",
            id: element.id ?? ""));
      });
      update();
    }
  }

  getDistrict(String? provinceId) async {
    listDataDistrict=[];
    if(provinceId==null) return;
    var data = await categoryRepository.getDistrict(provinceId: provinceId);
    if (data.length > 0) {
      data.forEach((element) {
        listDataDistrict.add(FormComboBox(
            key: element.id,
            title: element.district ?? "",
            id: element.id ?? ""));
      });
      update();
    }
  }

  getWard(String? districtId) async {
    listDataWard=[];
    if(districtId==null) return ;
    var data = await categoryRepository.getWard(districtId: districtId);
    if (data.length > 0) {
      data.forEach((element) {
        listDataWard.add(FormComboBox(
            key: element.id, title: element.ward ?? "", id: element.id ?? ""));
      });
      update();
    }
  }


}
