import 'package:viettel_app/models/category/district_model.dart';
import 'package:viettel_app/models/category/document_group_model.dart';
import 'package:viettel_app/models/category/province_model.dart';
import 'package:viettel_app/models/category/ward_model.dart';
import 'package:viettel_app/models/post/topic_model.dart';
import 'package:viettel_app/models/user/plant_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';

class _CategoryRepository extends GraphqlRepository {
  Future<List<ProvinceModel>> getProvince() async {
    var result = await this.query(
      """
      getProvince(){
        id
        province
      }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<ProvinceModel>.from(
          result.data?["g0"].map((d) => ProvinceModel.fromJson(d)));
    }
    return [];
  }

  Future<List<DistrictModel>> getDistrict({
    required String provinceId,
  }) async {
    var result = await this.query(
      """
        getDistrict(provinceId:"$provinceId"){
            id
            district
          }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<DistrictModel>.from(
          result.data?["g0"].map((d) => DistrictModel.fromJson(d)));
    }
    return [];
  }

  Future<List<WardModel>> getWard({
    required String districtId,
  }) async {
    var result = await this.query(
      """
        getWard(districtId:"$districtId"){
          id
          ward
        }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      // print(result.data?["g0"]);
      return List<WardModel>.from(
          result.data?["g0"].map((d) => WardModel.fromJson(d)));
    }
    return [];
  }
  String paramQueryPlants=""" id
            name
            image
            createdAt""";

  Future<List<PlantModel>> getPlants() async {
    var result = await this.query(
      """
       getAllPlant(q:{
          limit:1000,
          order:{
                  name: 1
                }
        }){
          data{
           $paramQueryPlants
          }
    }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<PlantModel>.from(
          result.data?["g0"]["data"].map((d) => PlantModel.fromJson(d)));
    }
    return [];
  }

  Future<List<TopicModel>> getAllTopic() async {
    var result = await this.query(
      """
        getAllTopic(q:{
                    order:{
                      _id:-1,
                        priority:-1
                    }
          }){
            data{
              id
              name
              image
              slug
            }
          }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<TopicModel>.from(
          result.data?["g0"]["data"].map((d) => TopicModel.fromJson(d)));
    }
    return [];
  }

  Future<List<DocumentGroupModel>> getAllDocumentGroup() async {
    var result = await this.query(
      """
       getAllDocumentGroup{
    data{
      id
      name
      code
      priority
      icon
      active
    }
  }
    """,
    );

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return List<DocumentGroupModel>.from(
          result.data?["g0"]["data"].map((d) => DocumentGroupModel.fromJson(d)));
    }
    return [];
  }

}

final categoryRepository = new _CategoryRepository();
