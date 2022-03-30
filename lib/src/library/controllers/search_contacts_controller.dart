import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/search_contacts/contact_model.dart';
import 'package:viettel_app/repositories/search_contacts_repo.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';

class SearchContactsController
    extends GraphqlListLoadMoreProvider<ContactModel> {
  static SearchContactsProvider _searchContactsProvider =
      SearchContactsProvider();
  static QueryInput _queryInput = QueryInput(
      order: {"name": 1});
  TextEditingController textEditingController = TextEditingController(text: "");

  SearchContactsController({query})
      : super(service: _searchContactsProvider, query: query ?? _queryInput, fragment: """
          id,
          name,
          phone,
          email,
          hospitals{
            id,
            name,
            phone,
            type,
            place{
              street,
              provinceId
              province,
              districtId,
              district,
              ward,
              wardId,
              fullAddress,
            },
            logo,
            images,
          }
        """);

  searchProvinces({required String provinceId, required BuildContext context}) {
    QueryInput queryInput =
        QueryInput(filter: {"place.provinceId": provinceId});
    this.loadAll(query: queryInput);
  }

  searchContacts({required String name}) {
    QueryInput queryInput = QueryInput(
      search: name,
      order: {"name": 1},
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

class SearchContactsProvider extends CrudRepository<ContactModel> {
  SearchContactsProvider() : super(apiName: "UsefulContact", isPaging: false);

  @override
  ContactModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return ContactModel.fromJson(json);
  }
}
