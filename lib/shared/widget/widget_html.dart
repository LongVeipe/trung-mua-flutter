import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget_image_view.dart';

class WidgetHtml extends StatelessWidget {
  String? dataHtml;
  double? fontSize;

  WidgetHtml({Key? key, this.dataHtml, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = dataHtml?.replaceAll("<img",
        '<img _height="${MediaQuery.of(context).size.width / 2}" width="${MediaQuery.of(context).size.width / 2}" object-fit: cover');
    return Html(
      data: """
          ${data ?? ""}
          """,
      style: {
        "body": Style(
          fontSize: FontSize(fontSize),
        ),
      },
      onLinkTap: (url, context, attributes, element) async {
        if (url != null) {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }
      },
      onImageTap: (url, context, attributes, element) {
        Get.to(WidgetImageView(
          url: url,
        ));
      },
    );
  }
}
