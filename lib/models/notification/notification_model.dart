import 'package:viettel_app/shared/util_convert/datetime_convert.dart';

/// id : "6124b15b269a3f57c5e6e886"
/// createdAt : "2021-08-24T08:44:11.603Z"
/// title : "BẢN TIN DỰ BÁO THỜI TIẾT"
/// body : "Kính gửi: Bà con nông dân\nThông tin dự báo thời tiết 7 ngày từ 19/07 đến 25/07/2021:\n+ Bà con có thể xem trong phần Video của ứng dụng \"Bệnh viện cây ăn quả\""
/// image : "https://i.imgur.com/Z9akm8x.png"
/// seen : false

class NotificationModel {
  String? id;
  String? createdAt;
  String? title;
  String? body;
  String? image;
  bool? seen;

  NotificationModel({
      this.id, 
      this.createdAt, 
      this.title, 
      this.body, 
      this.image, 
      this.seen});

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    // createdAt = json['createdAt'];
    createdAt =json['createdAt']!=null? dateTimeConvertString(
        dateTime: DateTime.parse(json['createdAt']), dateType: "dd/MM/yyyy"):null;
    title = json['title'];
    body = json['body'];
    image = json['image'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['title'] = title;
    map['body'] = body;
    map['image'] = image;
    map['seen'] = seen;
    return map;
  }

}