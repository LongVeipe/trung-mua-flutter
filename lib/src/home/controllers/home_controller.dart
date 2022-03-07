import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viettel_app/models/category/document_group_model.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/helper/location.dart';
import 'package:viettel_app/src/library/controllers/history_disease_scan_controller.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/support/controllers/support_controller.dart';
import 'package:viettel_app/src/tintuc/controllers/tintuc_controller.dart';

import 'quytrinh_controller.dart';
import 'weather_controller.dart';

class HomeController extends GetxController {
  List<DocumentGroupModel> listDocumentGroup = [];
  WeatherController? weatherController;
  TinTucController? tinTucController = TinTucController();
  int count = 0;

  bool showLoadingInit = true;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Get.put(QuyTrinhController());
    try {
      Get.put(SupportController());
      Get.put(HistoryDiseaseScanController());
    if (listDocumentGroup.isNotEmpty){
      listDocumentGroup.clear();
    }
    listDocumentGroup.add(DocumentGroupModel(icon: "assets/images/my_store.png", name: "Cửa hàng của tôi"));
    listDocumentGroup.add(DocumentGroupModel(icon: "assets/images/nearby_store.png", name: "Cửa hàng gần tôi"));
    listDocumentGroup.add(DocumentGroupModel(icon: "assets/images/inspect_origin.png", name: "Quản lý cửa hàng"));
    listDocumentGroup.add(DocumentGroupModel(icon: "assets/images/knowledge.png", name: "Kiến thức"));
    //   listDocumentGroup = await categoryRepository.getAllDocumentGroup();
    //   try {
    //     final position = await determinePosition().then((value) {
    //       print("position---- ${value?.latitude} - ${value?.longitude}");
    //       return value;
    //     });
    //     if(position!=null){
    //       weatherController = Get.put(WeatherController(
    //           query: QueryInput(filter: {
    //             "location": {
    //               "__near": {
    //                 "__geometry": {
    //                   "type": "Point",
    //                   "coordinates": [position.longitude, position.latitude]
    //                 }
    //               }
    //             }
    //           })));
    //     }
    //   } catch (error) {
    //     print("HomeController------ $error");
    //   }
    //   tinTucController = Get.put(TinTucController());
    } catch (error) {
      print("HomeController------ $error");
    }
    showLoadingInit = false;
    update();
  }
}
