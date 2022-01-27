import 'package:viettel_app/shared/util_convert/datetime_convert.dart';

import 'disease_model.dart';

/// id : "61272cbbf98f1b1e385cbec8"
/// createdAt : "2021-08-26T05:55:09.952Z"
/// images : ["https://i.imgur.com/4xKLjoe.jpg"]
/// results : [{"id":8,"className":"Bệnh bạc lá","percent":1.859377384185791,"image":"https://i.imgur.com/4xKLjoe.jpg"}]

class DiseaseScanModel {
  String? id;
  String? createdAt;
  String? dateCreatedAt;
  List<String>? images;
  List<Results>? results;

  DiseaseScanModel({
      this.id, 
      this.createdAt, 
      this.images, 
      this.results});

  DiseaseScanModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt =json['createdAt']!=null? dateTimeConvertString(
        dateTime: DateTime.parse(json['createdAt']), dateType: "HH:mm dd/MM/yyyy"):null;
    dateCreatedAt =json['createdAt']!=null? dateTimeConvertString(
        dateTime: DateTime.parse(json['createdAt']), dateType: "dd/MM/yyyy"):null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        if(v!=null){
          results?.add(Results.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['images'] = images;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// className : "Bệnh bạc lá"
/// id : 8
/// percent : 1.859377384185791
/// image : "https://i.imgur.com/4xKLjoe.jpg"
/// disease : {"id":"612bcfa09fbfb9b6f78ac9fd","name":"Bệnh bạc lá","ingredients":[{"id":"612c6496dfbbc4f2d04b0be9","name":"Hoạt chất 1","medicineCount":0},{"id":"6127bbff0524d32e4caa16ef","name":"Đá thời gian","medicineCount":1},{"id":"6125d8b60c409f9420af84bf","name":"Đá vô cực","medicineCount":1}]}

class Results {
  String? className;
  String? id;
  num? percent;
  String? image;
  DiseaseModel? disease;

  Results({
    this.className,
    this.id,
    this.percent,
    this.image,
    this.disease});

  Results.fromJson(dynamic json) {
    className = json['className'];
    id = json['id']?.toString();
    percent = json['percent'];
    image = json['image'];
    disease = json['disease'] != null ? DiseaseModel.fromJson(json['disease']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['className'] = className;
    map['id'] = id;
    map['percent'] = percent;
    map['image'] = image;
    if (disease != null) {
      map['disease'] = disease?.toJson();
    }
    return map;
  }

}

/// id : "612bcfa09fbfb9b6f78ac9fd"
/// name : "Bệnh bạc lá"
/// ingredients : [{"id":"612c6496dfbbc4f2d04b0be9","name":"Hoạt chất 1","medicineCount":0},{"id":"6127bbff0524d32e4caa16ef","name":"Đá thời gian","medicineCount":1},{"id":"6125d8b60c409f9420af84bf","name":"Đá vô cực","medicineCount":1}]
//
// class Disease {
//   String? id;
//   String? name;
//   List<Ingredients>? ingredients;
//
//   Disease({
//     this.id,
//     this.name,
//     this.ingredients});
//
//   Disease.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     if (json['ingredients'] != null) {
//       ingredients = [];
//       json['ingredients'].forEach((v) {
//         ingredients?.add(Ingredients.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     if (ingredients != null) {
//       map['ingredients'] = ingredients?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }

/// id : "612c6496dfbbc4f2d04b0be9"
/// name : "Hoạt chất 1"
/// medicineCount : 0

class Ingredients {
  String? id;
  String? name;
  String? code;
  int? medicineCount;

  Ingredients({
    this.id,
    this.name,
    this.code,
    this.medicineCount});

  Ingredients.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    medicineCount = json['medicineCount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['medicineCount'] = medicineCount;
    return map;
  }

}