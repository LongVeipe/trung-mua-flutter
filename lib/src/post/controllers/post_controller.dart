import 'package:viettel_app/models/post/post_model.dart';
import 'package:viettel_app/models/post/topic_model.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

List<TopicModel> listTopic = [];

class PostsController extends GraphqlListLoadMoreProvider<PostsModel> {
  static PostsProvider _postsProvider = PostsProvider();
  static QueryInput _queryInput = QueryInput(
      // filter: {"topicSlugs": topicSlugs},
      order: {"_id": -1, "createdAt": -1});

  PostsModel? postDetail;
  String? topic;

  PostsController({QueryInput? query})
      : super(
            service: _postsProvider, query: query ?? _queryInput, fragment: """
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
      topics{
        name
      }
  """) {
    getTopics();
  }

  getOnePost(String id) async {
    postDetail=null;
    try{
      var data = await _postsProvider.getOne(id: id, fragment: this.fragment);
      postDetail = data;
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

class PostsProvider extends CrudRepository<PostsModel> {
  PostsProvider() : super(apiName: "Post", isLoginRequired: false);

  @override
  PostsModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return PostsModel.fromJson(json);
  }
}
