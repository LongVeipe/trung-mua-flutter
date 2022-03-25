import 'package:viettel_app/models/search_contacts/contact_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';

final searchContactsRepository = new _SearchContactsRepository();

class _SearchContactsRepository extends GraphqlRepository {
  Future<List<ContactModel>> searchContacts(String provinceId) async {
    var result = await this.query("""
     getAllUsefulContacts(q:\$q){
      data{
       id,
          name,
          phone,
          email,
          hospitals{
            id,
            name,
            phone,
            email,
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
      }
    }
    """, variables: {
      "q": {
        "filter": {"place.provinceId": provinceId}
      }
    }, variablesParams: "(\$q : QueryGetListInput)");
    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<ContactModel>.from(
          result.data?["g0"]["data"].map((d) => ContactModel.fromJson(d)));
    }
    return [];
  }
}
