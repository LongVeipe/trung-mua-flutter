import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../config/theme/size-constant.dart';
import '../../config/theme/style-constant.dart';

class AppVersion extends StatelessWidget {
  Future<String> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initPackageInfo(),
      builder: (context, snapshot) {
        return Center(
          child: Text(
            snapshot.data == null ? "Loading..." : "Phiên Bản ${snapshot.data}",
            style: StyleConst.regularStyle(
                fontStyle: FontStyle.italic, fontSize: miniSize),
          ),
        );
      },
    );
  }
}
