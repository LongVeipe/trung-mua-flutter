import 'package:viettel_app/models/library/disease_model.dart';
import 'package:viettel_app/repositories/category_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

class LibraryController extends GraphqlListLoadMoreProvider<DiseaseModel> {
  static LibraryProvider _libraryProvider = LibraryProvider();

  LibraryController({query})
      : super(service: _libraryProvider, query: query, fragment: """
      id
      code
      createdAt
      name
      thumbnail
      images
      desc
      symptom
      bio
      farmingSolution
      bioSolution
      chemistSolution
      type
      ingredients{
            id
            name
            medicineCount
          }
     plants{
     ${categoryRepository.paramQueryPlants}
     }
  """);

  DiseaseModel? diseaseDetail;

  getOneDisease(String id) async {
    print("getOneDisease---- $id");
    diseaseDetail =
        await _libraryProvider.getOne(id: id, fragment: this.fragment);
    update();
  }
}

class LibraryProvider extends CrudRepository<DiseaseModel> {
  LibraryProvider() : super(apiName: "Disease");

  @override
  DiseaseModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return DiseaseModel.fromJson(json);
  }
}
