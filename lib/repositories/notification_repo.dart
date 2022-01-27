import 'package:viettel_app/models/notification/notification_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';

final notificationRepository = new _NotificationRepository();

class _NotificationRepository extends GraphqlRepository {
  Future<NotificationModel> readNotification(String notificationId) async {
    var result = await this.mutate("""
         readNotification(notificationId:"$notificationId"){
           id
            createdAt
            title
            body
            image
            seen
        }
    """);
    this.handleException(result);
    this.clearCache();
    if (result.data?["g0"] != null) {
      return NotificationModel.fromJson(result.data?["g0"]);
    }
    return NotificationModel();
  }

  Future<bool> readAllNotification() async {
    var result = await this.mutate("""readAllNotification""");
    this.handleException(result,showDataResult: true);
    this.clearCache();
    if (result.data?["g0"] != null) {
      return result.data?["g0"];
    }
    return false;
  }
}
