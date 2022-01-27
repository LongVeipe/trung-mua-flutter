/// id : "611500d52257253acb3e0f8b"
/// createdAt : "2021-08-12T11:07:01.553Z"
/// name : "Cây nhãn"
/// image : "https://i.imgur.com/iCvyMfd.jpg"

class PlantModel {
  String? id;
  String? createdAt;
  String? name;
  String? image;

  PlantModel({
      this.id, 
      this.createdAt, 
      this.name, 
      this.image});

  PlantModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}