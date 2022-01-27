/// content : "Câu trả lời text"
/// type : "Text"
/// createdTime : "2021-09-07T03:51:30.676515"
/// sessiongID : 2
/// id : 8

class MessageModel {
  String? content;
  String? type;
  String? createdUserID;
  String? createdTime;
  int? sessiongID;
  int? id;

  MessageModel({
      this.content, 
      this.type, 
      this.createdUserID,
      this.createdTime,
      this.sessiongID, 
      this.id});

  MessageModel.fromJson(dynamic json) {
    content = json['content'];
    type = json['type'];
    createdUserID = json['createdUserID'];
    createdTime = json['createdTime'];
    sessiongID = json['sessiongID'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['content'] = content;
    map['type'] = type;
    map['createdTime'] = createdTime;
    map['sessiongID'] = sessiongID;
    map['id'] = id;
    return map;
  }

}