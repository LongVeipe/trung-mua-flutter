import 'package:flutter/material.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/home/components/widget_icon_text.dart';
import 'package:viettel_app/src/tintuc/tintuc_detail_page.dart';

class ItemTinTucComponent extends StatelessWidget {
  final Widget? child;
  final String? image;
  final String? title;
  final String? time;
  final double? width;
  final double? height;
  final Function? onTap;

  const ItemTinTucComponent(
      {Key? key,
      this.child,
      this.image,
      this.height = 100,
      this.time = "",
      this.title = "",
      this.width = 100,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TinTucDetailPage.push(context);
        onTap?.call();
      },
      child: Container(
        // gắn thêm controller để fix error khi click vào nền không thực hiện sự kiện
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image != null
                    ? WidgetImageNetWork(
                        url: image,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AssetsConst.errorPlaceHolder,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: child ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title",
                        style: StyleConst.regularStyle(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WidgetIconText(
                        iconAsset: AssetsConst.iconTime,
                        text: "Ngày đăng: $time",
                        size: 12,
                        style: StyleConst.regularStyle(),
                      ),
                    ],
                  ),
            ),
            child == null
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(
                      Icons.navigate_next,
                      color: ColorConst.primaryColor,
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
