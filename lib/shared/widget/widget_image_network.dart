import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../export.dart';

class WidgetImageNetWork extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final Function? onTap;
  final BoxFit? fit;

  WidgetImageNetWork(
      {Key? key, this.url, this.height, this.width, this.onTap, this.fit})
      : super(key: key);

  final spinKit = SpinKitCircle(
    color: ColorConst.primaryColor,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty && url != "null") {
      return CachedNetworkImage(
        imageUrl: url!,
        fit: fit ?? BoxFit.cover,
        height: this.height ?? MediaQuery.of(context).size.width / 5,
        width: this.width ?? MediaQuery.of(context).size.width / 5,
        placeholder: (context, url) => SizedBox(
                  height: this.height ?? MediaQuery.of(context).size.width / 5,
                  width: this.width ?? MediaQuery.of(context).size.width / 5,
                  child: Center(child: spinKit)),
        errorWidget: (context, url, error) =>  Image(
              height: this.height ?? MediaQuery.of(context).size.width / 5,
              width: this.width ?? MediaQuery.of(context).size.width / 5,
              image: AssetImage(AssetsConst.errorPlaceHolder),
              fit: BoxFit.cover,
            ),
      );

      // return Image(
      //   image: NetworkImage(url ?? ""),
      //   fit: BoxFit.cover,
      //   height: this.height ?? MediaQuery.of(context).size.width / 5,
      //   width: this.width ?? MediaQuery.of(context).size.width / 5,
      //   loadingBuilder: (BuildContext _context, Widget _widget,
      //       ImageChunkEvent? imageChunkEvent) {
      //     if (imageChunkEvent == null) return _widget;
      //     return  SizedBox(
      //         height: this.height ?? MediaQuery.of(context).size.width / 5,
      //         width: this.width ?? MediaQuery.of(context).size.width / 5,
      //         child: Center(child: spinKit));
      //   },
      //   errorBuilder:
      //       (BuildContext context, Object exception, StackTrace? stackTrace) {
      //     return Image(
      //       height: this.height ?? MediaQuery.of(context).size.width / 5,
      //       width: this.width ?? MediaQuery.of(context).size.width / 5,
      //       image: AssetImage(AssetsConst.errorPlaceHolder),
      //       fit: BoxFit.cover,
      //     );
      //   },
      // );
    }
    return Image(
      height: this.height ?? MediaQuery.of(context).size.width / 5,
      width: this.width ?? MediaQuery.of(context).size.width / 5,
      image: AssetImage(AssetsConst.errorPlaceHolder),
      fit: BoxFit.cover,
    );
  }
}
