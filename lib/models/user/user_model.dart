import 'place_model.dart';
import 'plant_model.dart';

/// user : {"id":"6121e0f7eec8e621d6ab434c","avatar":null,"uid":"8S9SEHP55VNwRRlcqxp7iis0Hex2","name":"","phone":"+84356132121","place":null}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiRkFSTUVSIiwiX2lkIjoiNjEyMWUwZjdlZWM4ZTYyMWQ2YWI0MzRjIiwidXNlcm5hbWUiOiIrODQzNTYxMzIxMjEiLCJpYXQiOjE2Mjk2MTA2MDEsImV4cCI6MTYzMjIwMjYwMX0.gPVUpgG8SXgtT3svUPjASFaJ4HrnW7WlK4dVfB6FntY"

class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }
}

/// id : "6121e0f7eec8e621d6ab434c"
/// avatar : null
/// uid : "8S9SEHP55VNwRRlcqxp7iis0Hex2"
/// name : ""
/// phone : "+84356132121"
/// place : null

class User {
  String? id;
  String? avatar;
  String? uid;
  String? name;
  String? phone;
  num? area;
  PlaceModel? place;
  PlantModel? plant;

  User(
      {this.id,
      this.avatar,
      this.uid,
      this.name,
      this.phone,
      this.area,
      this.plant,
      this.place});

  User.fromJson(dynamic json) {
    id = json['id'];
    avatar = json['avatar'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    area = json['area'];
    place = json['place']!=null? PlaceModel.fromJson(json['place']):null;
    plant =json['plant']!=null? PlantModel.fromJson(json['plant']):null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['avatar'] = avatar;
    map['uid'] = uid;
    map['name'] = name;
    map['phone'] = phone;
    map['place'] = place;
    map['plant'] = plant;
    return map;
  }
}
