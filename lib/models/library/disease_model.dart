import 'package:viettel_app/models/user/plant_model.dart';
import 'package:viettel_app/shared/util_convert/datetime_convert.dart';

import 'disease_scan_model.dart';

/// id : "6125d5dbd6c5bf92b1985df6"
/// code : "D10002"
/// createdAt : "2021-08-25T05:32:11.981Z"
/// name : "Covid-19"
/// thumbnail : null
/// images : []
/// desc : null
/// symptom : null
/// bio : null
///

class DiseaseModel {
  String? id;
  String? code;
  String? createdAt;
  String? name;
  String? alternativeName;
  String? scienceName;
  String? thumbnail;
  List<String>? images;
  String? desc;
  String? symptom;
  String? bio;
  String? farmingSolution;
  String? bioSolution;
  String? chemistSolution;
  String? type;
  List<PlantModel>? plants;
  List<Ingredients>? ingredients;

  DiseaseModel(
      {this.id,
      this.code,
      this.createdAt,
      this.name,
      this.thumbnail,
      this.images,
      this.desc,
      this.symptom,
      this.bio,
      this.bioSolution,
      this.chemistSolution,
      this.farmingSolution,
      this.type,
      this.plants,
      this.ingredients,
      this.alternativeName,
      this.scienceName});

  DiseaseModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    // createdAt = json['createdAt'];
    createdAt = json['createdAt'] != null
        ? dateTimeConvertString(
            dateTime: DateTime.parse(json['createdAt']),
            dateType: "HH:mm dd/MM/yyyy")
        : null;

    name = json['name'];
    alternativeName = json['alternativeName'];
    scienceName = json['scienceName'];
    thumbnail = json['thumbnail'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(v);
      });
    }
    desc = json['desc'];
    symptom = json['symptom'];
    bio = json['bio'];
    bioSolution = json['bioSolution'];
    chemistSolution = json['chemistSolution'];
    farmingSolution = json['farmingSolution'];
    type = json['type'];
    if (json['ingredients'] != null) {
      ingredients = [];
      json['ingredients'].forEach((v) {
        ingredients?.add(Ingredients.fromJson(v));
      });
    }
    if (json['plants'] != null) {
      plants = [];
      json['plants'].forEach((v) {
        plants?.add(PlantModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['thumbnail'] = thumbnail;
    if (images != null) {
      map['images'] = images?.toList();
    }
    map['desc'] = desc;
    map['symptom'] = symptom;
    map['bio'] = bio;
    return map;
  }
}
