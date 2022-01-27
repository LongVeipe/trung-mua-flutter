import 'package:geolocator/geolocator.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/models/user/user_model.dart';
import 'package:viettel_app/services/graphql/graphql_repo.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/widget/widget-combobox.dart';

class _AuthRepository extends GraphqlRepository {
  String param = """
          id
          avatar
          uid
          name
          phone
          area
          place{
            street
            province
            provinceId
            district
            districtId
            ward
            wardId
            fullAddress
            location
            note
          }
         plant{
            id
            createdAt
            name
            image
          }
  """;

  Future<UserModel> loginRepo({
    required String idToken,
  }) async {
    final deviceId = await SPref.instance.get(AppKey.deviceId);
    final deviceToken = await SPref.instance.get(AppKey.deviceToken);
    print("loginRepo-idToken.toString()- ${idToken.toString()}");
    print("loginRepo-deviceId.toString()- ${deviceId.toString()}");
    print("loginRepo-deviceToken.toString()- ${deviceToken.toString()}");
    this.clearCache();
    var result = await this.mutate("""
    login(idToken:\$idToken
              ,deviceId:\$deviceId
              ,deviceToken:\$deviceToken
              )
     {
      user{$param}
    token
     }
    """,
        variables: {
          "idToken": "$idToken",
          "deviceId": "$deviceId",
          "deviceToken": "$deviceToken"
        },
        variablesParams: "(\$idToken : String!"
            ",\$deviceId: String"
            ",\$deviceToken: String"
            ")");

    this.handleException(result);
    if (result.data?["g0"] != null) {
      return UserModel.fromJson(result.data?["g0"]);
    }
    return UserModel();
  }

  Future<User> userUpdateMe(
      {required String name,
      required String phone,
      String? avatar = "",
      String? plantId = "",
      String? area,
      FormComboBox? province,
      FormComboBox? district,
      FormComboBox? ward,
      String? address,
      Position? position}) async {
    var result = await this.mutate("""
         userUpdateMe(data:{
          name:"$name",
          phone:"$phone",
          avatar:"$avatar",
          ${plantId!.isNotEmpty ? """plantId:"$plantId",""" : ""}
          area:$area,
          place:{
            provinceId:"${province?.id ?? ""}",
            province:"${province?.title ?? ""}",
            districtId:"${district?.id ?? ""}",
            district:"${district?.title ?? ""}",
            wardId:"${ward?.id ?? ""}",
            ward:"${ward?.title ?? ""}",
            ${position == null ? "" : """
            location: {
                  type : "Point",
                  coordinates : [ 
                      "${position.longitude}",
                      "${position.latitude}"
                  ]
              },
            """} 
            street:"$address"
          },
        }){
        $param
        }
    """);
    this.clearCache();
    this.handleException(result);
    if (result.data?["g0"] != null) {
      // print("aaaaaa----- ${result.data?["g0"]}");
      return User.fromJson(result.data?["g0"]);
    }
    return User();
  }

  Future<User> userGetMe() async {
    this.clearCache();
    var result = await this.query("""
    userGetMe{
         $param
      }
    """);
    print("api--token: ${SPref.instance.get(AppKey.xToken)}");
    this.handleException(result, showDataResult: true);
    if (result.data?["g0"] != null) {
      return User.fromJson(result.data?["g0"]);
    }
    return User();
  }
}

final authRepository = new _AuthRepository();
