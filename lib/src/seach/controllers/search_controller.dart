import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:viettel_app/src/library/controllers/library_controller.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';

class SearchController extends GetxController {
  static const String tag = "SearchController";

  int indexCurrent = 0;
  TextEditingController keySearch = TextEditingController(text: "");
  PostsController postsController = Get.put(PostsController(), tag: tag);
  LibraryController libraryController = Get.put(LibraryController(),tag: tag);

  search(BuildContext context) {
    WaitingDialog.show(context);
    libraryController.lastItem=false;
    postsController.lastItem=false;
    postsController.loadAll(
        query: QueryInput(
            search: keySearch.text,
            limit: 10,page: 1,
            order: {"priority": -1, "_id": -1, "createdAt": -1}));
    libraryController.loadAll(query: QueryInput(
      search: keySearch.text,
      limit: 10,page: 1,
    ));
    WaitingDialog.turnOff();

    update();
  }
}
