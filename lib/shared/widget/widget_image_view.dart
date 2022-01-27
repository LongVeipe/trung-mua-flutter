import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:viettel_app/config/theme/color-constant.dart';

class WidgetImageView extends StatelessWidget {
  final String? url;
  final String? path;

  WidgetImageView({Key? key,  this.url,this.path}) : super(key: key);
  final spinKit = SpinKitCircle(
    color: ColorConst.primaryColor,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Stack(
          children: [
            _photoView(),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.arrow_back_outlined,color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _photoView() {
    return PhotoView(
      imageProvider: NetworkImage(url??""),
      // Contained = the smallest possible size to fit one dimension of the screen
      minScale: PhotoViewComputedScale.contained * 0.8,
      // Covered = the smallest possible size to fit the whole screen
      maxScale: PhotoViewComputedScale.covered * 3,
      loadingBuilder:(context, event) {
        return  Center(child: spinKit);
      },
      // enableRotation: true,

    );
  }
}
