import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/export.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/shared/widget/widget-button.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/camera_search/controllers/camera_search_controller.dart';

import '../list_result_page.dart';
import 'image_view_mini_picture.dart';
import 'model_file_review.dart';
import 'view_check_type_ai.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  List<ModelFileReview> listImages = [];

  double _scale = 1;
  double _baseFontScale = 1;
  bool isShowPicture = true;
  bool statVideo = false;
  ModelFileReview? videoTemplate;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the liRst of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.width;
    return Scaffold(
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Column(
        children: [
          WidgetAppbar(
            title: "Chụp hình",
            turnOffSearch: true,
            turnOffNotification: true,
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the Future is complete, display the preview.
                        return GestureDetector(
                            onScaleStart: (value) {
                              _baseFontScale = _scale;
                            },
                            onScaleUpdate: (value) {
                              // print(value.scale);
                              if (value.scale == 1.0) {
                                return;
                              }
                              _scale = (_baseFontScale * value.scale)
                                  .clamp(0.5, 5.0);
                              _controller.setZoomLevel(_scale);
                            },
                            child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                home: CameraPreview(_controller)));
                      } else {
                        // Otherwise, display a loading indicator.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height / 2 -
                      MediaQuery.of(context).padding.top -
                      56,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Để nhận biết chính xác, vui lòng cung cấp nhiều hình ảnh",
                                  style: StyleConst.regularStyle(
                                      fontSize: miniSize),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(3, (index) {
                                      ModelFileReview? data;
                                      try {
                                        data = listImages[index];
                                      } catch (error) {
                                        data = null;
                                      }
                                      return ImageViewMiniPicture(
                                        data: data ?? ModelFileReview(),
                                        onTapWhenImageEmpty: () {
                                          getImageAlbum();
                                        },
                                        onDelete: () {
                                          setState(() {
                                            listImages.removeAt(index);
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(1),
                          //   margin: EdgeInsets.only(
                          //       top: 16,
                          //       bottom: 16,
                          //       right: MediaQuery.of(context).size.width / 4,
                          //       left: MediaQuery.of(context).size.width / 4),
                          //   decoration: BoxDecoration(
                          //       border:
                          //           Border.all(color: ColorConst.primaryColor),
                          //       borderRadius: BorderRadius.circular(5)),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: widgetButtom(
                          //               title: "Chụp hình",
                          //               onTap: () {
                          //                 setState(() {
                          //                   isShowPicture = true;
                          //                 });
                          //               },
                          //               colorText: isShowPicture
                          //                   ? ColorConst.white
                          //                   : ColorConst.textPrimary,
                          //               backgroundColor: isShowPicture
                          //                   ? ColorConst.primaryColor
                          //                   : ColorConst.white,
                          //               borderRadius: BorderRadius.only(
                          //                   topLeft: Radius.circular(5),
                          //                   bottomLeft: Radius.circular(5)))),
                          //       Expanded(
                          //           child: widgetButtom(
                          //               onTap: () {
                          //                 setState(() {
                          //                   isShowPicture = false;
                          //                 });
                          //               },
                          //               title: "Quay video",
                          //               backgroundColor: !isShowPicture
                          //                   ? ColorConst.primaryColor
                          //                   : ColorConst.white,
                          //               colorText: isShowPicture
                          //                   ? ColorConst.textPrimary
                          //                   : ColorConst.white,
                          //               borderRadius: BorderRadius.only(
                          //                   topRight: Radius.circular(5),
                          //                   bottomRight: Radius.circular(5))))
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 16 +
                                      MediaQuery.of(context).padding.bottom,
                                  left: 10,
                                  right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () async {
                                          getImageAlbum();
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            AssetsConst.iconAlbum,
                                            width: 52,
                                            height: 52,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: statVideo == false
                                        ? GestureDetector(
                                            onTap: () async {
                                              WaitingDialog.show(context);

                                              if (listImages.length >= 3)
                                                return;

                                              if (isShowPicture == false &&
                                                  statVideo == false) {
                                                try {
                                                  videoTemplate = null;
                                                  final imageTemplate =
                                                      await _controller
                                                          .takePicture();
                                                  videoTemplate =
                                                      ModelFileReview(
                                                          path: null,
                                                          type: "video",
                                                          imageTemplate:
                                                              imageTemplate
                                                                  .path);
                                                  await _controller
                                                      .startVideoRecording();
                                                  setState(() {
                                                    statVideo = true;
                                                  });
                                                  // final aaa = await _controller
                                                  //     .stopVideoRecording();
                                                  // print(aaa.path);
                                                } catch (e) {
                                                  print(e);
                                                }
                                              } else {
                                                try {
                                                  await _initializeControllerFuture;
                                                  final image =
                                                      await _controller
                                                          .takePicture();
                                                  try {
                                                    await GallerySaver.saveImage(
                                                        image.path,
                                                        albumName:
                                                            "SinhVatGayHai");
                                                  } catch (error) {
                                                    print(error);
                                                  }
                                                  setState(() {
                                                    listImages.add(
                                                        ModelFileReview(
                                                            path: image.path,
                                                            type: "image",
                                                            imageTemplate:
                                                                image.path));
                                                  });
                                                } catch (e) {
                                                  // If an error occurs, log the error to the console.
                                                  print(e);
                                                  WaitingDialog.turnOff();
                                                }
                                              }
                                              WaitingDialog.turnOff();
                                            },
                                            child: Image.asset(
                                              AssetsConst.iconTakePicture,
                                              width: 52,
                                              height: 52,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              try {
                                                setState(() {
                                                  statVideo = false;
                                                });
                                                final videoData =
                                                    await _controller
                                                        .stopVideoRecording();
                                                print(videoData.path);
                                                videoTemplate?.path =
                                                    videoData.path;
                                                if (videoTemplate != null)
                                                  setState(() {
                                                    listImages.add(
                                                        videoTemplate ??
                                                            ModelFileReview());
                                                  });
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            child: Image.asset(
                                              AssetsConst.iconTakePicture,
                                              color: Colors.red,
                                              width: 52,
                                              height: 52,
                                            ),
                                          ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: WidgetButton(
                                        text: "Tra cứu",
                                        radius: 100,
                                        paddingBtnHeight: 10,
                                        paddingBtnWidth: 0,
                                        textColor: Colors.white,
                                        onTap: () async {
                                          List<String> images = [];
                                          viewTypeAI.showSelectedType(context,
                                              (value) async {
                                            Get.find<CameraSearchController>()
                                                .typePlant = value[1].type;
                                            Get.find<CameraSearchController>()
                                                .type = value[0].type;

                                            if (listImages.length > 0) {
                                              images = List.from(listImages
                                                  .map((e) => e.path));
                                            } else {
                                              showSnackBar(
                                                  title: "Thông báo",
                                                  body:
                                                      "Vui lòng chụp ít nhật một hình.");
                                              return;
                                            }
                                            await Get.find<
                                                    CameraSearchController>()
                                                .scanDisease(
                                                    images: images,
                                                    context: context);
                                            Get.to(ListResultPage());
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getImageAlbum() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if ((images?.length ?? 0) > (3 - listImages.length)) {
      showSnackBar(
          title: "Khuyến cáo",
          body: "Vui lòng chọn tối đa ${3 - listImages.length} ảnh.");
      return;
    }

    for (var item in images ?? []) {
      listImages.add(ModelFileReview(
          type: "image", path: item?.path, imageTemplate: item?.path));
    }
    setState(() {});
  }
}
