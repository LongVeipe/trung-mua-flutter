import 'package:viettel_app/models/tintuc/tin_tuc_model.dart';
import 'package:viettel_app/models/tintuc/topic_model.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

List<TopicModel> listTopic = [];

class TinTucController extends GraphqlListLoadMoreProvider<TinTucModel> {
  static TinTucProvider _tinTucProvider = TinTucProvider();
  static QueryInput _queryInput = QueryInput(
      // filter: {"topicSlugs": topicSlugs},
      order: {"_id": -1, "createdAt": -1});

  TinTucModel? tinTucDetail;
  String? topic;

  TinTucController({QueryInput? query})
      : super(
            service: _tinTucProvider, query: query ?? _queryInput, fragment: """
      id
      createdAt
      title
      excerpt
      slug
      status
      publishedAt
      featureImage
      ogImage
   		content
      ogTitle
      ogDescription
      seen
  """) {
    getTopics();
  }

  getOnePost(String id) async {
    tinTucDetail=null;
    try{
      var data = await _tinTucProvider.getOne(id: id, fragment: this.fragment);
      tinTucDetail = data;
    }catch(error){
      print("getOnePost---error: $error");
    }
    update();
  }

  getTopics() async {
    // topicSlugs = [];
    await categoryRepository.getAllTopic().then((value) {
      listTopic = value;
      // value.forEach((element) {
      //   topicSlugs.add(element.slug ?? "");
      // });
      update();
      // this.loadAll(
      //     query: QueryInput(
      //         filter: {"topicSlugs": topicSlugs},
      //         order: {"priority": -1, "_id": -1, "createdAt": -1}));
      // update();
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}

class TinTucProvider extends CrudRepository<TinTucModel> {
  TinTucProvider() : super(apiName: "Post");

  @override
  TinTucModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return TinTucModel.fromJson(json);
  }
}
