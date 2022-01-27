/// id : 27
/// chatBotResponses : [{"type":"text","text":"Xin lỗi. Bạn có thể nhắc lại ý định của bạn được không?"}]

class InsertSessionModel {
  int? id;
  List<ChatBotResponses>? chatBotResponses;

  InsertSessionModel({
      this.id, 
      this.chatBotResponses});

  InsertSessionModel.fromJson(dynamic json) {
    id = json['id'];
    if (json['chatBotResponses'] != null) {
      chatBotResponses = [];
      json['chatBotResponses'].forEach((v) {
        chatBotResponses?.add(ChatBotResponses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    if (chatBotResponses != null) {
      map['chatBotResponses'] = chatBotResponses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "text"
/// text : "Xin lỗi. Bạn có thể nhắc lại ý định của bạn được không?"

class ChatBotResponses {
  String? type;
  String? text;

  ChatBotResponses({
      this.type, 
      this.text});

  ChatBotResponses.fromJson(dynamic json) {
    type = json['type'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = type;
    map['text'] = text;
    return map;
  }

}