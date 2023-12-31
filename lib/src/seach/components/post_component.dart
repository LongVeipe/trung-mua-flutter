import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/components/item_post_component.dart';
import 'package:viettel_app/src/seach/components/search_none_componet.dart';
import 'package:viettel_app/src/seach/controllers/search_controller.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';
import 'package:viettel_app/src/post/post_detail_page.dart';

import '../../../export.dart';

class PostComponent extends StatefulWidget {
  const PostComponent({Key? key}) : super(key: key);

  @override
  _PostComponentState createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  ScrollController scrollController = ScrollController();

  SearchController searchController = Get.find<SearchController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (searchController.postsController.lastItem = false) {
          searchController.postsController.loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<PostsController>(
        tag: SearchController.tag,
        builder: (controller) {
          return SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.loadMoreItems.value.length + 1,
                (index) {
                  if (index == controller.loadMoreItems.value.length) {
                    if (controller.loadMoreItems.value.length >=
                            (controller.pagination.value.limit ?? 10) ||
                        controller.loadMoreItems.value.length == 0) {
                      if (controller.lastItem == true) {
                        return SearchNoneComponent();
                      }
                      return WidgetLoading(
                        notData: controller.lastItem,
                      );
                    } else {
                      print("controller.lastItem---- ${controller.lastItem}");
                      return SizedBox.shrink();
                    }
                  }
                  if (controller.lastItem == false &&
                      controller.loadMoreItems.value.length == 0) {
                    return WidgetLoading();
                  }
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ColorConst.primaryBackgroundLight, width: 2))),
                    padding: const EdgeInsets.all(16.0),
                    child: ItemPostComponent(
                      image:
                          "${controller.loadMoreItems.value[index].featureImage}",
                      title: "${controller.loadMoreItems.value[index].title}",
                      time:
                          "${controller.loadMoreItems.value[index].createdAt}",
                      topics: controller.loadMoreItems.value[index].topics,
                      onTap: () {
                        PostDetailPage.push(context,
                            id: controller.loadMoreItems.value[index].id ?? "", tag: SearchController.tag);
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
