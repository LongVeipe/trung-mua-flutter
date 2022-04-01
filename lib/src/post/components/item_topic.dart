import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';
import 'package:viettel_app/models/post/topic_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/src/post/controllers/post_controller.dart';

import '../list_posts_page.dart';

class ItemTopic extends StatefulWidget {
  final TopicModel data;

  ItemTopic({Key? key, required this.data}) : super(key: key);

  @override
  _ItemTopicState createState() => _ItemTopicState();
}

class _ItemTopicState extends State<ItemTopic> {
  final PostsController _tinTucController =
      Get.find<PostsController>(tag: ListTinTucPage.tag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_tinTucController.topic == widget.data.slug) {
          _tinTucController.topic = null;
        } else {
          _tinTucController.topic = widget.data.slug;
        }
        if (_tinTucController.topic == null) {
          _tinTucController.query = QueryInput(
              order: {"priority": -1, "_id": -1, "createdAt": -1},
              limit: 10,
              page: 1);
          _tinTucController.loadAll();
        } else {
          _tinTucController.query = QueryInput(filter: {
            "topicSlugs": [_tinTucController.topic]
          }, order: {
            "priority": -1,
            "_id": -1,
            "createdAt": -1
          }, limit: 10, page: 1);
          _tinTucController.loadAll();
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (_tinTucController.topic == widget.data.slug)
                ? ColorConst.primaryColor
                : Colors.white,
            border: Border.all(
              color: (_tinTucController.topic == widget.data.slug)
                  ? ColorConst.primaryColor
                  : ColorConst.borderInputColor,
            )),
        child: Text(
          "${widget.data.name}",
          style: StyleConst.mediumStyle(
              color: (_tinTucController.topic == widget.data.slug)
                  ? Colors.white
                  : ColorConst.textPrimary),
        ),
      ),
    );
  }
}
