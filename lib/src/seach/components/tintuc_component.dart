import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/components/item_tintuc_component.dart';
import 'package:viettel_app/src/seach/components/search_none_componet.dart';
import 'package:viettel_app/src/seach/controllers/search_controller.dart';
import 'package:viettel_app/src/tintuc/controllers/tintuc_controller.dart';
import 'package:viettel_app/src/tintuc/tintuc_detail_page.dart';

import '../../../export.dart';

class TinTucComponent extends StatefulWidget {
  const TinTucComponent({Key? key}) : super(key: key);

  @override
  _TinTucComponentState createState() => _TinTucComponentState();
}

class _TinTucComponentState extends State<TinTucComponent> {
  ScrollController scrollController = ScrollController();

  SearchController searchController = Get.find<SearchController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (searchController.tinTucController.lastItem = false) {
          searchController.tinTucController.loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<TinTucController>(
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
                                color: ColorConst.backgroundColor, width: 2))),
                    padding: const EdgeInsets.all(16.0),
                    child: ItemTinTucComponent(
                      image: "${controller.loadMoreItems.value[index].featureImage}",
                      title: "${controller.loadMoreItems.value[index].title}",
                      time:
                          "${controller.loadMoreItems.value[index].createdAt}",
                      onTap: () {
                        TinTucDetailPage.push(context,
                            id: controller.loadMoreItems.value[index].id ?? "");
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
