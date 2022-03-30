import 'package:flutter/material.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';

import '../../export.dart';
import 'components/identified_recently_screen.dart';
import 'components/useful_contacts_screen.dart';
import 'components/tabbar_componet.dart';
import 'components/library_svgh_screen.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConst.white,
        child: Column(
          children: [
            WidgetAppbar(
              title: "Thư viện",
            ),
            Expanded(
              child: TabBarComponent(
                listScreen: [
                  IdentifiedRecentlyScreen(),
                  LibraryScreen(),
                  UsefulContacts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
