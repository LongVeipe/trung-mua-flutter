import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/size-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/helper/print_log.dart';
import 'package:viettel_app/src/components/item_post_component.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login_requirement/login_requirement_page.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';
import 'package:viettel_app/src/post/list_posts_page.dart';
import 'package:viettel_app/src/post/post_detail_page.dart';

import 'components/home_appbar.dart';
import 'components/quytrinh_screen.dart';
import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const String tag = "HomePage";

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
    Get.delete<PostsController>(tag: HomePage.tag);
    Get.put(PostsController(), tag: HomePage.tag);
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
                                        assetsImage: homeController
                                            .listDocumentGroup[index].icon,
                                        title: homeController
                                                .listDocumentGroup[index]
                                                .name ??
                                            "",
                                        onTap: () async {
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
                                            if (index == 1) {
                                              url =
                                                  "scheme-miagri-shop://deeplinking.miagrishop/";
                                              try {
                                                print(await canLaunch(url));
                                                return await launch(url)
                                                    .then((value) async {
                                                  if (value == false) {
                                                    if (Platform.isAndroid) {
                                                      return await launch(
                                                          "https://play.google.com/store/apps/details?id=mcom.app.miagrishop");
                                                    } else {
                                                      return await launch(
                                                          "https://apps.apple.com/vn/app/miagri/id1611335505");
                                                    }
                                                  }
                                                });
                                              } catch (error) {
                                                printLog("error: $error");
                                                if (Platform.isAndroid) {
                                                  return await launch(
                                                      "https://play.google.com/store/apps/details?id=mcom.app.miagrishop");
                                                } else {
                                                  return await launch(
                                                      "https://apps.apple.com/vn/app/miagri/id1611335505");
                                                }
                                              }
                                            } else if (index == 2) {
                                              url =
                                                  "scheme-miagri-manage://deeplinking.miagri/";
                                              try {
                                                print(await canLaunch(url));
                                                return await launch(url)
                                                    .then((value) async {
                                                  if (value == false) {
                                                    if (Platform.isAndroid) {
                                                      return await launch(
                                                          "https://play.google.com/store/apps/details?id=mcom.miagri.manage");
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
                                                      "https://play.google.com/store/apps/details?id=mcom.miagri.manage");
                                                } else {
                                                  return await launch(
                                                      "https://apps.apple.com/vn/app/miagri-qu%E1%BA%A3n-l%C3%BD/id1607440248");
                                                }
                                              }
                                            } else if (index == 0) {
                                              if (Get.find<AuthController>()
                                                  .isLogged())
                                                url =
                                                    "https://miagri.vn/${SPref.instance.get(AppKey.phoneNumber)}";
                                              else
                                                return Get.to(
                                                    LoginRequirementPage());
                                            }

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

                              ///tin mới
                              GetBuilder<PostsController>(
                                tag: HomePage.tag,
                                builder: (postController) {
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
                                                Get.to(ListPostsPage());
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
                                        // visible:
                                        //     homeController.postsController !=
                                        //         null,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            postController
                                                .loadMoreItems.value.length,
                                            (index) => Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: ColorConst
                                                              .primaryBackgroundLight,
                                                          width: 2))),
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: ItemPostComponent(
                                                image:
                                                    "${postController.loadMoreItems.value[index].featureImage}",
                                                title:
                                                    "${postController.loadMoreItems.value[index].title}",
                                                time:
                                                    "${postController.loadMoreItems.value[index].createdAt}",
                                                topics: postController
                                                    .loadMoreItems
                                                    .value[index]
                                                    .topics,
                                                onTap: () {
                                                  Get.to(PostDetailPage(
                                                      id: postController
                                                              .loadMoreItems
                                                              .value[index]
                                                              .id ??
                                                          "", tag: HomePage.tag,));
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
            ))),
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
