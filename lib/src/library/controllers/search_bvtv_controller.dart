import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/search_bvtv/bvtv_model.dart';
import 'package:viettel_app/repositories/search_bvtv_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';

class SearchBVTVController extends GraphqlListLoadMoreProvider<BvtvModel> {
  static SearchBVTVProvider _searchBVTVProvider = SearchBVTVProvider();

  SearchBVTVController({query})
      : super(service: _searchBVTVProvider, query: query, fragment: """
        id
        name
        place{
          fullAddress
          provinceId
          location
        }
        intro
        logo
        phone
  """);


  searchBVTV({required String provinceId, required BuildContext context}){
    QueryInput queryInput=QueryInput(
      filter: {"place.provinceId": provinceId}
    );
    this.loadAll(query: queryInput);
  }

// List<BvtvModel> bvtv=[];
//
// searchBVTV(
//     {required String provinceId, required BuildContext context}) async {
//   WaitingDialog.show(context);
//   try {
//     bvtv = await searchBVTVRepository.searchBVTV(provinceId);
//   } catch (error) {
//     print("searchBVTV----$error");
//   }
//   WaitingDialog.turnOff();
//   update();
// }
}

class SearchBVTVProvider extends CrudRepository<BvtvModel> {
  SearchBVTVProvider():super(apiName: "Hospital");
  @override
  BvtvModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return BvtvModel.fromJson(json);
  }
}
