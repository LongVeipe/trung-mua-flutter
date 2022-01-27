import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/camera_search/components/model_file_review.dart';

class DisplayPictureScreen extends StatelessWidget {
  final ModelFileReview data;

  const DisplayPictureScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          WidgetAppbar(
            title: "Xem trước",
            turnOffSearch: true,
          ),
          Expanded(
              child: data.type == "image"
                  ? _photoView()
                  : VideoApp(
                      path: data.path ?? "",
                    )),
        ],
      ),
    );
  }

  Widget _photoView() {
    return PhotoView(
      imageProvider: FileImage(File(data.imageTemplate ?? "")),
      // Contained = the smallest possible size to fit one dimension of the screen
      minScale: PhotoViewComputedScale.contained * 0.8,
      // Covered = the smallest possible size to fit the whole screen
      maxScale: PhotoViewComputedScale.covered * 3,
      // enableRotation: true,

    );
  }
}

class VideoApp extends StatefulWidget {
  final String path;

  const VideoApp({Key? key, required this.path}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: ColorConst.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
