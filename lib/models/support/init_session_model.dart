import 'package:viettel_app/shared/util_convert/datetime_convert.dart';

/// id : 7
/// className : "Bọ xít dài, bọ xít hôi Leptocorisa acuta"
/// percent : 33.33333333333333

class InitSessionModel {
  int? id;
  String? createdTime;
  String? createdUserID;
  String? className;
  num? accuracy;

  InitSessionModel(
      {this.id,
      this.createdTime,
      this.createdUserID,
      this.className,
      this.accuracy});

  InitSessionModel.fromJson(dynamic json) {
    id = json['id'];
    if (json["createdTime"]!=null && (json["createdTime"] as String).isNotEmpty) {
      createdTime = dateTimeConvertString(
          dateType: "HH:mm dd/MM/yyyy",
          dateTime: DateTime.parse(json['createdTime']));
    }
    // createdTime = json['createdTime'];
    createdUserID = json['createdUserID'];
    className = json['className'];
    accuracy = json['accuracy'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['className'] = className;
    map['accuracy'] = accuracy;
    return map;
  }
}
