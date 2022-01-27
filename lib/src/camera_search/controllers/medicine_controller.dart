import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

class MedicineController extends GraphqlListLoadMoreProvider<Ingredients>{
  static MedicineProvider _medicineProvider=MedicineProvider();

  MedicineController({query}) : super(service:_medicineProvider,query: query,fragment: """
      id
      code
      name
  """ );

}
class MedicineProvider extends CrudRepository<Ingredients>{
  MedicineProvider():super(apiName: "Medicine");
  @override
  Ingredients fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return Ingredients.fromJson(json);
  }

}