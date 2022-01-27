// /// images : ["https://i.imgur.com/XQtl89D.jpg"]
// /// results : [{"id":1,"className":"Bệnh đạo ôn","percent":2.1059632301330566,"image":"https://i.imgur.com/XQtl89D.jpg"}]
// /// _id : "612b3122dfbbc441324b093f"
// /// owner : {"_id":"611deac8c40d850e494b3f39","name":"Ông Hoàng Cày thuê","phone":"0123456789","email":"","role":"FARMER"}
// /// createdAt : "2021-08-29T07:03:08.347Z"
// /// updatedAt : "2021-08-29T07:03:08.347Z"
// /// __v : 0
//
// class ScanDiseaseModel {
//   List<String>? images;
//   List<Results>? results;
//   String? id;
//   Owner? owner;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//   String? error;
//
//   ScanDiseaseModel({
//       this.images,
//       this.results,
//       this.id,
//       this.owner,
//       this.createdAt,
//       this.updatedAt,
//       this.error,
//       this.v});
//
//   ScanDiseaseModel.fromJson(dynamic json) {
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     if (json['results'] != null) {
//       results = [];
//       json['results'].forEach((v) {
//         results?.add(Results.fromJson(v));
//       });
//     }
//     id = json['_id'];
//     owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     v = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['images'] = images;
//     if (results != null) {
//       map['results'] = results?.map((v) => v.toJson()).toList();
//     }
//     map['_id'] = id;
//     if (owner != null) {
//       map['owner'] = owner?.toJson();
//     }
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = v;
//     return map;
//   }
//
// }
//
// /// _id : "611deac8c40d850e494b3f39"
// /// name : "Ông Hoàng Cày thuê"
// /// phone : "0123456789"
// /// email : ""
// /// role : "FARMER"
//
// class Owner {
//   String? id;
//   String? name;
//   String? phone;
//   String? email;
//   String? role;
//
//   Owner({
//       this.id,
//       this.name,
//       this.phone,
//       this.email,
//       this.role});
//
//   Owner.fromJson(dynamic json) {
//     id = json['_id'];
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//     role = json['role'];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['_id'] = id;
//     map['name'] = name;
//     map['phone'] = phone;
//     map['email'] = email;
//     map['role'] = role;
//     return map;
//   }
//
// }
//
// /// id : 1
// /// className : "Bệnh đạo ôn"
// /// percent : 2.1059632301330566
// /// image : "https://i.imgur.com/XQtl89D.jpg"
//
// class Results {
//   String? id;
//   String? className;
//   double? percent;
//   String? image;
//
//   Results({
//       this.id,
//       this.className,
//       this.percent,
//       this.image});
//
//   Results.fromJson(dynamic json) {
//     id = json['id']?.toString();
//     className = json['className'];
//     percent = json['percent'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['id'] = id;
//     map['className'] = className;
//     map['percent'] = percent;
//     map['image'] = image;
//     return map;
//   }
//
// }