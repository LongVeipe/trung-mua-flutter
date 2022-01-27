import 'package:viettel_app/models/user/place_model.dart';

/// id : "6114fa070d1fc9368ef77fc7"
/// name : "BV Cây ăn quả"
/// place : {"fullAddress":"Mỹ Long, Cai Lậy, Tiền Giang, Việt Nam","provinceId":null,"location":{"type":"Point","coordinates":[106.1861489,10.3510158],"_id":"61274d24036b67321c125cea"}}
/// intro : ""
/// logo : "https://maivangthuduc.com/wp-content/uploads/2017/12/20-C%C3%82Y-XANH.jpg"
/// phone : null

class BvtvModel {
  String? id;
  String? name;
  PlaceModel? place;
  String? intro;
  String? logo;
  String? phone;

  BvtvModel({
      this.id, 
      this.name, 
      this.place, 
      this.intro, 
      this.logo, 
      this.phone});

  BvtvModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    place = json['place'] != null ? PlaceModel.fromJson(json['place']) : null;
    intro = json['intro'];
    logo = json['logo'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (place != null) {
      map['place'] = place?.toJson();
    }
    map['intro'] = intro;
    map['logo'] = logo;
    map['phone'] = phone;
    return map;
  }

}
