import 'package:viettel_app/services/graphql/graphql_repo.dart';

final feedBackRepository = new _FeedBackRepository();

class _FeedBackRepository extends GraphqlRepository {
  Future<String?> createFeedback(
      {required String title, required String message}) async {
    var result = await this.mutate("""
             createFeedback(data:{
            title:"$title",
            message:"$message"
          }){
            id
          }
    """);
    this.handleException(result,showDataResult: true);
    if (result.data?["g0"] != null) {
      return result.data?["g0"]["id"] as String;
    }
    return null;
  }
}
