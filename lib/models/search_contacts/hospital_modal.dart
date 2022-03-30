import 'dart:convert';

import 'package:viettel_app/models/user/place_model.dart';

/// id : "6114fa070d1fc9368ef77fc7"
/// name : "BV Cây ăn quả"
/// place : {"fullAddress":"Mỹ Long, Cai Lậy, Tiền Giang, Việt Nam","provinceId":null,"location":{"type":"Point","coordinates":[106.1861489,10.3510158],"_id":"61274d24036b67321c125cea"}}
/// intro : ""
/// logo : "https://maivangthuduc.com/wp-content/uploads/2017/12/20-C%C3%82Y-XANH.jpg"
/// phone : null

class HospitalModel {
  String? id;
  String? name;
  String? type;
  PlaceModel? place;
  String? intro;
  String? logo;
  List<String>? images;
  String? phone;
  String? email;

  HospitalModel({
    this.id,
    this.name,
    this.type,
    this.place,
    this.intro,
    this.logo,
    this.images,
    this.email,
    this.phone});

  HospitalModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    place = json['place'] != null ? PlaceModel.fromJson(json['place']) : null;
    type = json['type'];
    intro = json['intro'];
    logo = json['logo'];
    if(json['images'] != null){
      images = [];
      json['images'].forEach((image) {
        images?.add(image);
      });
    }
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    if (place != null) {
      map['place'] = place?.toJson();
    }
    map['intro'] = intro;
    map['logo'] = logo;
    map['image'] = images;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}
