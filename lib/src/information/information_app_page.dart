import 'package:flutter/material.dart';
import 'package:viettel_app/shared/widget/widget-version.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';

import '../../export.dart';

class InformationAppPage extends StatefulWidget {
  const InformationAppPage({Key? key}) : super(key: key);

  @override
  _InformationAppPageState createState() => _InformationAppPageState();
}

class _InformationAppPageState extends State<InformationAppPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConst.white,
        child: Column(
          children: [
            WidgetAppbar(
              title: "Thông tin",
              turnOffSearch: true,
            ),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}

