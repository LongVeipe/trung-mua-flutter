import 'package:flutter/material.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import '../../export.dart';

class WidgetCircleAvatar extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final Function? onTap;
  final double? radius;
  final Color? borderColor;

  const WidgetCircleAvatar(
      {Key? key,
      this.url,
      this.height,
      this.width,
      this.onTap,
      this.radius,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: borderColor ?? ColorConst.borderInputColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            100,
          ),
          child: WidgetImageNetWork(
            url: url ?? "",
            height: this.height ?? MediaQuery.of(context).size.width / 5,
            width: this.width ?? MediaQuery.of(context).size.width / 5,
            fit: BoxFit.cover,
          ),
          // child:Image(
          //   image: NetworkImage(
          //        url ?? ""),
          //   fit: BoxFit.cover,
          //   height: this.height ?? MediaQuery.of(context).size.width / 5,
          //   width: this.width ?? MediaQuery.of(context).size.width / 5,
          //   loadingBuilder: (BuildContext _context, Widget _widget,
          //       ImageChunkEvent? imageChunkEvent) {
          //     if (imageChunkEvent == null) return _widget;
          //     return Image(
          //       height: this.height ?? MediaQuery.of(context).size.width / 5,
          //       width: this.width ?? MediaQuery.of(context).size.width / 5,
          //       image: AssetImage(AssetsConst.errorPlaceHolder),
          //       fit: BoxFit.cover,
          //     );
          //   },
          //   errorBuilder: (BuildContext context, Object exception,
          //       StackTrace? stackTrace) {
          //     return ClipRRect(
          //       borderRadius: BorderRadius.circular(radius ?? 100.0),
          //       child: Image(
          //         height: this.height ?? MediaQuery.of(context).size.width / 5,
          //         width: this.width ?? MediaQuery.of(context).size.width / 5,
          //         image: AssetImage(AssetsConst.logoFlashScreen),
          //         fit: BoxFit.cover,
          //       ),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
