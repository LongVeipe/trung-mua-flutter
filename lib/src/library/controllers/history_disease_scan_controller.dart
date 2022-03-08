import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

class HistoryDiseaseScanController
    extends GraphqlListLoadMoreProvider<DiseaseScanModel> {
  static HistoryDiseaseScanProvider _historyDiseaseScanProvider =
      HistoryDiseaseScanProvider();

  HistoryDiseaseScanController({query})
      : super(
            service: _historyDiseaseScanProvider,
            query: query ??
                QueryInput(order: {"priority": -1, "_id": -1, "createdAt": -1}),
            fragment: """
      id
      createdAt
      images
      results{
        className
        id
        accuracy
        imageUrl
        disease{
            id
            code
            createdAt
            name
          alternativeName
          scienceName
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
        }
      }
  """);
}

class HistoryDiseaseScanProvider extends CrudRepository<DiseaseScanModel> {
  HistoryDiseaseScanProvider() : super(apiName: "DiseaseScan");

  @override
  DiseaseScanModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return DiseaseScanModel.fromJson(json);
  }
}
