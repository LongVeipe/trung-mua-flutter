import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/main.dart';
import 'package:viettel_app/src/camera_search/user_manua_cameral_page.dart';
import 'components/take_picture_screen.dart';
import 'controllers/camera_search_controller.dart';

bool firstOpenCamera = true;

class CameraSearchPage extends StatefulWidget {
  const CameraSearchPage({Key? key}) : super(key: key);

  @override
  _CameraSearchPageState createState() => _CameraSearchPageState();
}

class _CameraSearchPageState extends State<CameraSearchPage> {
  late CameraController controller;

  // InAppPurchaseController _inAppPurchaseController =
  //     Get.put(InAppPurchaseController());
  bool turnOn=false;
  // bool showInAppPurchase=false;

  @override
  void initState() {
    super.initState();
    Get.put(CameraSearchController());
    try {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (error) {}
    // _inAppPurchaseController.init();
  }

  @override
  void dispose() {
    super.dispose();
    try {
      controller.dispose();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    // return GetBuilder<InAppPurchaseController>(
    //   builder: (inAppController) {
        // print("${jsonEncode(inAppController.consumables)}");
        // for(var item in inAppController.myProductId){
        //     if(inAppController.consumables.indexWhere((element) => element==item)>=0){
        //       showInAppPurchase=false;
        //       break;
        //     }else{
        //       showInAppPurchase=true;
        //     }
        // }
        // print(showInAppPurchase);
        return Stack(
          children: [
            body(),
            // Visibility(
            //   visible: showInAppPurchase
            //       // && turnOn==false
            //   ,
            //   child: Container(
            //     height: MediaQuery.of(context).size.height,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.black.withOpacity(.7),
            //   ),
            // ),
            // Visibility(
            //   visible: showInAppPurchase
            //       // && turnOn==false
            //   ,
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       padding: EdgeInsets.all(16),
            //       margin: EdgeInsets.symmetric(horizontal: 20),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.white),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SingleChildScrollView(
            //             child: Column(
            //               children: List.generate(
            //                   inAppController.products.length,
            //                   (index) => Padding(
            //                     padding: const EdgeInsets.symmetric(vertical: 10),
            //                     child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Expanded(
            //                               child: Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     "${inAppController.products[index].title}",
            //                                     style: StyleConst.boldStyle(),
            //                                   ),
            //                                   Text(
            //                                     "${inAppController.products[index].description}",
            //                                     style: StyleConst.regularStyle(),
            //                                   ),
            //                                   Container(
            //                                     padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.grey.withOpacity(.5),
            //                                       borderRadius: BorderRadius.circular(10)
            //                                     ),
            //                                     child: Text(
            //                                       "14 ngày dùng thử",
            //                                       style: StyleConst.regularStyle(fontSize: miniSize),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             SizedBox(width: 10,),
            //                             WidgetButton(
            //                               textColor: Colors.white,
            //                               text:
            //                                   "${inAppController.products[index].price}",
            //                               onTap: () {
            //                                 inAppController.buyProduct(
            //                                     inAppController.products[index]);
            //                               },
            //                             )
            //                           ],
            //                         ),
            //                   )),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           WidgetButton(
            //             text: "Thoát",
            //             textColor: Colors.white,
            //             onTap: () {
            //               // print("xxx$turnOn");
            //               // setState(() {
            //               //   turnOn=true;
            //               // });
            //               Navigator.of(context).pop();
            //             },
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        );
    //   },
    // );
  }

  Widget body() {
    if (firstOpenCamera == true) {
      return UserManualCameraPage(
        callBack: () {
          setState(() {
            firstOpenCamera = false;
          });
        },
      );
    }
    if (!controller.value.isInitialized) {
      return Container();
    }
    return TakePictureScreen(
      camera: controller.description,
    );
  }
}
