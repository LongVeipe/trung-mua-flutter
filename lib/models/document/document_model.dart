import 'dart:io';

class DocumentModel {
  String? id;
  String? name;
  String? desc;
  String? groupCode;
  List<Attachments>? attachments;

  DocumentModel({this.id, this.name, this.groupCode, this.attachments});

  DocumentModel.fromJson(dynamic json) {
    groupCode = json['groupCode'];
    name = json['name'];
    desc = json['desc'];
    id = json['id'];
    attachments = json["attachments"] != null
        ? List<Attachments>.from(
            json["attachments"].map((d) => Attachments.fromJson(d)))
        : null;
  }
}

class Attachments {
  String? id;
  String? downloadUrl;
  String? name;
  String? mimetype;
  double valueProgress = 0.0;
  File? file;

  Attachments({this.downloadUrl, this.name, this.mimetype});

  Attachments.fromJson(dynamic json) {
    id = json['id'];
    downloadUrl = json['downloadUrl'];
    name = json['name'];
    mimetype = json['mimetype'];
  }
}
