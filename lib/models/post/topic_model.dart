/// id : "611e4a96dfcc488cce201165"
/// name : "Tin tức"
/// image : ""
/// slug : "tin-tuc-1495"

class TopicModel {
  String? id;
  String? name;
  String? image;
  String? slug;

  TopicModel({
      this.id, 
      this.name, 
      this.image, 
      this.slug});

  TopicModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['slug'] = slug;
    return map;
  }

}