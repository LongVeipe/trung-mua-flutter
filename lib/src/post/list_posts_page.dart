import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/shared/widget/widget_appbar.dart';
import 'package:viettel_app/src/components/item_post_component.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';

import '../../export.dart';
import 'components/item_topic.dart';
import 'post_detail_page.dart';

class ListPostsPage extends StatefulWidget {
  ListPostsPage({Key? key}) : super(key: key);
  static const String tag = "ListTinTucPage";

  @override
  _ListPostsPageState createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  ScrollController scrollController = ScrollController();
  PostsController postsController =
      Get.put(PostsController(), tag: ListPostsPage.tag);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        postsController.loadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: ColorConst.white,
        child: GetBuilder<PostsController>(
          tag: ListPostsPage.tag,
          builder: (controller) {
            if (controller.initialized == false) return SizedBox();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetAppbar(
                  title: "Tin tức",
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: ColorConst.borderInputColor, width: 3))),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        listTopic.length,
                        (index) => ItemTopic(
                              data: listTopic[index],
                            )),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                              return WidgetLoading(
                                notData: controller.lastItem,
                              );
                            } else {
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
                                        color: ColorConst.backgroundColor,
                                        width: 2))),
                            padding: const EdgeInsets.all(16.0),
                            child: ItemPostComponent(
                              image:
                                  "${controller.loadMoreItems.value[index].featureImage}",
                              title:
                                  "${controller.loadMoreItems.value[index].title}",
                              time:
                                  "${controller.loadMoreItems.value[index].createdAt}",
                              topics:
                                  controller.loadMoreItems.value[index].topics,
                              onTap: () {
                                PostDetailPage.push(context,
                                    id: controller
                                            .loadMoreItems.value[index].id ??
                                        "");
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
