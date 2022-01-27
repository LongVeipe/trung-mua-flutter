import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/src/camera_search/components/model_file_review.dart';

import 'display_picture_screen.dart';

class ImageViewMiniPicture extends StatelessWidget {
  final ModelFileReview data;
  final Function? onDelete;
  final Function? onTapWhenImageEmpty;

  const ImageViewMiniPicture(
      {Key? key, required this.data, this.onDelete, this.onTapWhenImageEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            radius: Radius.circular(10),
            child: data.imageTemplate == null
                ? GestureDetector(
                    onTap: () {
                      onTapWhenImageEmpty?.call();
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      width: 50,
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            data: data,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Image.file(
                          File(data.imageTemplate ?? ""),
                          width: 50,
                          height: 50,
                        ),
                        Visibility(
                          visible: data.type == "video",
                          child: Positioned(
                            top: 0,
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Icon(
                                Icons.video_collection_outlined,
                                color: ColorConst.primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
        Visibility(
          visible: data.imageTemplate != null,
          child: Positioned(
            top: 0,
            right: 0,
            width: 16,
            height: 16,
            child: GestureDetector(
              onTap: () {
                onDelete?.call();
              },
              child: ImageIcon(
                AssetImage(AssetsConst.iconDelete),
                color: ColorConst.primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
