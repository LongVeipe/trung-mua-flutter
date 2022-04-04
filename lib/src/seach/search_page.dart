import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/shared/widget/widget_search.dart';
import 'package:viettel_app/src/library/components/library_svgh_screen.dart';
import 'package:viettel_app/src/seach/components/tabbar_component.dart';
import 'package:viettel_app/src/seach/controllers/search_controller.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';

import '../../export.dart';
import 'components/search_none_componet.dart';
import 'components/post_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = Get.put(SearchController());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            WidgetAppbar(
              title: "Tìm kiếm",
              turnOffSearch: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22, right: 20, left: 20),
              child: WidgetSearch(
                controller: searchController.keySearch,
                hintText: "Nhập nội dung tìm kiếm",
                onSubmitted: (value) {
                  searchController.search(context);
                },
              ),
            ),
            Expanded(
              child: TabBarComponent(
                listScreen: [
                  PostComponent(),
                  LibraryScreen(tag: SearchController.tag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noData() {
    return Padding(
        padding: EdgeInsets.only(top: 56), child: SearchNoneComponent());
  }
}
