import 'dart:io';

import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/size-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/helper/print_log.dart';
import 'package:viettel_app/src/camera_search/detail_result_page.dart';
import 'package:viettel_app/src/components/item_tintuc_component.dart';
import 'package:viettel_app/src/home/components/home_weather.dart';
import 'package:viettel_app/src/library/controllers/history_disease_scan_controller.dart';
import 'package:viettel_app/src/library/library_page.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/tintuc/controllers/tintuc_controller.dart';
import 'package:viettel_app/src/tintuc/list_tintuc_page.dart';
import 'package:viettel_app/src/tintuc/tintuc_detail_page.dart';

import 'components/home_appbar.dart';
import 'components/quytrinh_screen.dart';
import 'components/widget_icon_text.dart';
import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.delete<HomeController>();
    Get.put(HomeController());
  }

  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final spinkit = SpinKitCircle(
      color: ColorConst.primaryColor,
      size: 50.0,
    );
    Widget loading = Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          spinkit,
          Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'Đang cập nhật dữ liệu',
                style: StyleConst.regularStyle(),
              ))
        ],
      ),
    );

    return GetBuilder<HomeController>(
      builder: (homeController) {
        print("====================================================");
        print(homeController.listDocumentGroup.length);
        return SizedBox.expand(
          child: Stack(
            children: [
              Container(
                color: ColorConst.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          GetBuilder<AuthController>(builder: (controller) {
                            return HomeAppbar(
                              userCurrent: controller.userCurrent,
                            );
                          }),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFF8A9EAD).withOpacity(0.19),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          print("RefreshIndicator...");
                          homeController.onInit();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                      homeController.listDocumentGroup.length,
                                      (index) {
                                    return category(
                                        // assetsImage: AssetsConst
                                        //     .iconHomeQuyTrinhPhongTru,
                                        assetsImage: homeController
                                            .listDocumentGroup[index].icon,
                                        title: homeController
                                                .listDocumentGroup[index]
                                                .name ??
                                            "",
                                        onTap: () async {
                                          // Get.to(QuyTrinhScreen(
                                          //   title: homeController
                                          //           .listDocumentGroup[index]
                                          //           .name ??
                                          //       "",
                                          //   groupCode: homeController
                                          //           .listDocumentGroup[index]
                                          //           .code ??
                                          //       "",
                                          // ));
                                          if (index == 3) {
                                            Get.to(QuyTrinhScreen(
                                              title: homeController
                                                      .listDocumentGroup[index]
                                                      .name ??
                                                  "",
                                              groupCode: homeController
                                                      .listDocumentGroup[index]
                                                      .code ??
                                                  "",
                                            ));
                                          } else {
                                            print(
                                                "Phone number = ${SPref.instance.get(AppKey.phoneNumber)}");
                                            String? url;
                                            if (index == 1)
                                              url = "https://mismart.ai";
                                            else if (index == 2) {
                                              // if (Platform.isAndroid) {
                                              //   url =
                                              //       "scheme://deeplinking.miagri/";
                                              // } else {
                                              url =
                                                  "scheme://deeplinking.miagri/";
                                              // }
                                              try {
                                                // print(await canLaunch(url));
                                                return await launch(url).then((value) async {
                                                  if(value==false){
                                                    if (Platform.isAndroid) {
                                                      return await launch(
                                                          "https://play.google.com/store/apps/details?id=mcom.app.miagrinv");
                                                    } else {
                                                      return await launch(
                                                          "https://apps.apple.com/vn/app/miagri-qu%E1%BA%A3n-l%C3%BD/id1607440248");
                                                    }
                                                  }
                                                });
                                              } catch (error) {
                                                printLog("error: $error");
                                                if (Platform.isAndroid) {
                                                  return await launch(
                                                      "https://play.google.com/store/apps/details?id=mcom.app.miagrinv");
                                                } else {
                                                  return await launch(
                                                      "https://apps.apple.com/us/app/miagri-nh%C3%A2n-vi%C3%AAn/id1591231114");
                                                }
                                              }
                                            } else if (index == 0)
                                              url =
                                                  "https://mismart.ai/${SPref.instance.get(AppKey.phoneNumber)}";

                                            if (await canLaunch(
                                                url.toString())) {
                                              print(url.toString());
                                              try {
                                                await launch(url.toString(),
                                                    forceSafariVC: true);
                                              } catch (error) {
                                                print(error);
                                              }
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          }
                                        });
                                  }),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 12, left: 20, bottom: 16, right: 20),
                              //   child: HomeWeather(
                              //     weatherController:
                              //         homeController.weatherController,
                              //   ),
                              // ),

                              // GetBuilder<HistoryDiseaseScanController>(
                              //   builder: (historyController) {
                              //     if (historyController
                              //             .loadMoreItems.value.length ==
                              //         0) return SizedBox();
                              //     return Column(
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               top: 19,
                              //               left: 20,
                              //               right: 20,
                              //               bottom: 12),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Text(
                              //                 "Nhận diện gần đây",
                              //                 style: StyleConst.boldStyle(
                              //                     fontSize: titleSize),
                              //               ),
                              //               GestureDetector(
                              //                 onTap: () {
                              //                   Get.to(LibraryPage());
                              //                 },
                              //                 child: Row(
                              //                   children: [
                              //                     Text(
                              //                       "Xem tất cả",
                              //                       style:
                              //                           StyleConst.regularStyle(
                              //                               color: ColorConst
                              //                                   .primaryColor),
                              //                     ),
                              //                     Icon(
                              //                       Icons.navigate_next,
                              //                       color:
                              //                           ColorConst.primaryColor,
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         SingleChildScrollView(
                              //           scrollDirection: Axis.horizontal,
                              //           child: Row(
                              //             children: List.generate(
                              //               historyController
                              //                   .loadMoreItems.value.length,
                              //               (index) => Row(
                              //                 children: List.generate(
                              //                     historyController
                              //                             .loadMoreItems
                              //                             .value[index]
                              //                             .results
                              //                             ?.length ??
                              //                         0,
                              //                     (index2) => Container(
                              //                           width: MediaQuery.of(
                              //                                       context)
                              //                                   .size
                              //                                   .width /
                              //                               1.3,
                              //                           decoration: BoxDecoration(
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           10),
                              //                               color:
                              //                                   Colors.white),
                              //                           margin: EdgeInsets.only(
                              //                               left: 16),
                              //                           padding:
                              //                               EdgeInsets.all(10),
                              //                           child:
                              //                               ItemTinTucComponent(
                              //                             image:
                              //                                 historyController
                              //                                     .loadMoreItems
                              //                                     .value[index]
                              //                                     .results?[
                              //                                         index2]
                              //                                     .image,
                              //                             onTap: () {
                              //                               Get.to(
                              //                                   DetailResultPage(
                              //                                 diseaseModel:
                              //                                     historyController
                              //                                         .loadMoreItems
                              //                                         .value[
                              //                                             index]
                              //                                         .results?[
                              //                                             index2]
                              //                                         .disease,
                              //                                 // id: historyController
                              //                                 //         .loadMoreItems
                              //                                 //         .value[
                              //                                 //             index]
                              //                                 //         .results?[
                              //                                 //             index2]
                              //                                 //         .id ??
                              //                                 //     "",
                              //                               ));
                              //                             },
                              //                             child: Column(
                              //                               crossAxisAlignment:
                              //                                   CrossAxisAlignment
                              //                                       .start,
                              //                               children: [
                              //                                 Text(
                              //                                   historyController
                              //                                           .loadMoreItems
                              //                                           .value[
                              //                                               index]
                              //                                           .results?[
                              //                                               index2]
                              //                                           .disease?.name ??
                              //                                       "",
                              //                                   style: StyleConst
                              //                                       .boldStyle(),
                              //                                   maxLines: 3,
                              //                                   overflow: TextOverflow.ellipsis,
                              //                                 ),
                              //                                 SizedBox(height: 5,),
                              //                                 WidgetIconText(
                              //                                   iconAsset: AssetsConst.iconTime,
                              //                                   text: "${  historyController
                              //                                       .loadMoreItems
                              //                                       .value[
                              //                                   index].createdAt??""}",
                              //                                   size: 12,
                              //                                   style: StyleConst.regularStyle(fontSize: miniSize),
                              //                                 ),
                              //
                              //
                              //                               ],
                              //                             ),
                              //                           ),
                              //                         )),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 16,
                              //         )
                              //       ],
                              //     );
                              //   },
                              // ),

                              ///tin mới
                              GetBuilder<TinTucController>(
                                init: homeController.tinTucController,
                                builder: (tinTucController) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 19,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tin tức mới nhất",
                                              style: StyleConst.boldStyle(
                                                  fontSize: titleSize),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ListTinTucPage());
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Xem tất cả",
                                                    style:
                                                        StyleConst.regularStyle(
                                                            color: ColorConst
                                                                .primaryColor),
                                                  ),
                                                  Icon(
                                                    Icons.navigate_next,
                                                    color:
                                                        ColorConst.primaryColor,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ItemTinTucComponent(),
                                      Visibility(
                                        visible:
                                            homeController.tinTucController !=
                                                null,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            tinTucController
                                                .loadMoreItems.value.length,
                                            (index) => Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: ColorConst
                                                              .backgroundColor,
                                                          width: 2))),
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: ItemTinTucComponent(
                                                // image: "https://danviet.mediacdn.vn/fckeditor/upload/2018/20180523/images/sau-rieng.jpg",
                                                image:
                                                    "${tinTucController.loadMoreItems.value[index].featureImage}",
                                                title:
                                                    "${tinTucController.loadMoreItems.value[index].title}",
                                                time:
                                                    "${tinTucController.loadMoreItems.value[index].createdAt}",
                                                onTap: () {
                                                  TinTucDetailPage.push(context,
                                                      id: tinTucController
                                                              .loadMoreItems
                                                              .value[index]
                                                              .id ??
                                                          "");
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: homeController.showLoadingInit,
                  child: Container(
                      color: Colors.black38,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Center(child: loading)))
            ],
          ),
        );
      },
    );
  }

  Widget category(
      {required String assetsImage, String? title, Function? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(5),
        width: mediaQueryData.size.width / 4 - 10,
        decoration: BoxDecoration(
            color: ColorConst.primaryColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
                    child: Image.asset(
              assetsImage,
              height: 30,
              width: 30,
            ))
                // child: Center(
                //   child: ImageIcon(
                //     AssetImage(assetsImage),
                //     size: 20,
                //     color: ColorConst.primaryColor,
                //   ),
                // ),
                ),
            Expanded(
              child: Text(
                "$title",
                style: StyleConst.regularStyle(fontSize: miniSize),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
