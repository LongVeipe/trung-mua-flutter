import 'package:flutter/material.dart';
import 'package:viettel_app/models/notification/notification_model.dart';
import 'package:viettel_app/repositories/notification_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';

class NotificationController
    extends GraphqlListLoadMoreProvider<NotificationModel> {
  static NotificationProvider _notificationProvider = NotificationProvider();
  static QueryInput _queryInput = QueryInput(order: {"_id": -1});

  NotificationController({query})
      : super(
            service: _notificationProvider,
            query: query ?? _queryInput,
            fragment: """
      id
      createdAt
      title
      body
      image
      seen
  """);

  NotificationModel? notificationDetail;

  getOneNotification(String id, BuildContext context) async {
    notificationDetail = null;
    readNotification(id);
    try {
      notificationDetail =
          await _notificationProvider.getOne(id: id, fragment: this.fragment);
    } catch (error) {
      print("getOneNotification-----$error");
    }
    update();
  }

  readAllNotification() async {
    var data = await notificationRepository.readAllNotification();
    if (data == true) {
      refreshData();
      update();
    }
  }

  readNotification(String id) async {
    var data = await notificationRepository.readNotification(id);
    if (data.id != null && data.id!.isNotEmpty) {
      refreshData();
      update();
    }
  }

  refreshData() async {
    await _notificationProvider.clearCache();
    this.loadAll(query: QueryInput(limit: 10, page: 1, order: {"_id": -1}));
  }
}

class NotificationProvider extends CrudRepository<NotificationModel> {
  NotificationProvider() : super(apiName: "Notification");

  @override
  NotificationModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return NotificationModel.fromJson(json);
  }
}
