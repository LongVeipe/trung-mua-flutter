import 'package:azlistview/azlistview.dart';
import 'package:viettel_app/models/search_contacts/hospital_modal.dart';
import 'package:viettel_app/models/user/place_model.dart';

/// id : "6114fa070d1fc9368ef77fc7"
/// name : "BV Cây ăn quả"
/// place : {"fullAddress":"Mỹ Long, Cai Lậy, Tiền Giang, Việt Nam","provinceId":null,"location":{"type":"Point","coordinates":[106.1861489,10.3510158],"_id":"61274d24036b67321c125cea"}}
/// intro : ""
/// logo : "https://maivangthuduc.com/wp-content/uploads/2017/12/20-C%C3%82Y-XANH.jpg"
/// phone : null

class ContactModel extends ISuspensionBean{
  String? id;
  String? name;
  List<HospitalModel>? hospitals;
  String? phone;
  String? email;

  ContactModel({this.id, this.name, this.hospitals, this.email, this.phone});

  ContactModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['hospitals'] != null) {
      hospitals = [];
      json["hospitals"].forEach((v){
        hospitals?.add(HospitalModel.fromJson(v));
      });
      // json['hospitals'].forEach((v){
      //   hospitals?.add(HospitalModel.fromJson(v));
      // });
    }
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (hospitals != null) {
      hospitals?.toList().forEach((element) {
        map[hospitals].add(element.toJson());
      });
    }
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

  @override
  String getSuspensionTag() {
    return this.name?[0].toUpperCase() ?? "A";
    throw UnimplementedError();
  }
}
