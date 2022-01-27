import 'package:viettel_app/models/search_bvtv/bvtv_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';

final searchBVTVRepository = new _SearchBVTVRepository();

class _SearchBVTVRepository extends GraphqlRepository {
  Future<List<BvtvModel>> searchBVTV(String provinceId) async {
    var result = await this.query("""
     getAllHospital(q:\$q){
      data{
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
      }
    }
    """, variables: {
      "q": {
        "filter": {"place.provinceId": provinceId}
      }
    }, variablesParams: "(\$q : QueryGetListInput)");
    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<BvtvModel>.from(
          result.data?["g0"]["data"].map((d) => BvtvModel.fromJson(d)));
    }
    return [];
  }
}
