import 'dart:convert';

import 'package:viettel_app/models/library/disease_scan_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';

final scanDiseaseRepository = new _ScanDiseaseRepository();

class _ScanDiseaseRepository extends GraphqlRepository {
  Future<DiseaseScanModel?> scanDisease(
      List<String> images, {required String type,required String treeType}) async {
    var result = await this.mutate("""
     createDiseaseScan(images:${jsonEncode(images)},type:"$type",plantId:"$treeType"){
              id
              createdAt
              images
              results{
                className
                id
                percent
                image
                disease{
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
                        }
                }
    }
    """);
    this.handleException(result, showDataResult: true);
    if (result.data?["g0"] != null) {
      return DiseaseScanModel.fromJson(result.data?["g0"]);
    }
    return DiseaseScanModel();
  }
}
