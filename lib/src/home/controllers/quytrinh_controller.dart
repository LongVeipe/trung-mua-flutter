import 'package:viettel_app/models/document/document_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

class KnowledgeController extends GraphqlListLoadMoreProvider<DocumentModel> {
  static DocumentProvider _quyTrinhProvider = DocumentProvider();

  KnowledgeController({query})
      : super(service: _quyTrinhProvider, query: query, fragment: """
       id
        groupCode
        name
        desc
        attachments{
          id
          downloadUrl
          name
          mimetype
        }
      """);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Future<DocumentModel>  getOneDocument(String id){
      return _quyTrinhProvider.getOne(id: id ,fragment: this.fragment);
  }

}

class DocumentProvider extends CrudRepository<DocumentModel> {
  DocumentProvider():super(apiName: "Document", isLoginRequired: false);
  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return DocumentModel.fromJson(json);
  }
}
