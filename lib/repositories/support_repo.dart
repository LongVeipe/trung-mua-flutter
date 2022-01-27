import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/models/support/init_session_model.dart';
import 'package:viettel_app/models/support/insert_session_model.dart';
import 'package:viettel_app/models/support/message_model.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:http/http.dart' as http;

final supportRepository = new _SupportRepository();

class _SupportRepository {
  var dio = Dio(); // with default Options
  var client = http.Client();

  _SupportRepository() {
// Set default configs
    dio.options.baseUrl = 'https://chatbot.api.mismart.ai/';
    dio.options.connectTimeout = 15000; //5s
    dio.options.receiveTimeout = 3000;
  }

  // {
  // "id": 7,
  // "className": "Bọ xít dài, bọ xít hôi Leptocorisa acuta",
  // "percent": 33.33333333333333
  // }
  Future<InitSessionModel> initMessages(List<String> images,String type) async {
    var createdUserID = SPref.instance.get(AppKey.staffId);
    Map<String, dynamic> formData = {
      "images": images,
      "createdID": createdUserID,
      "type": type
    };
    print("${jsonEncode(formData)}");
    var dataResult = await dio.post("sessions", data: formData);
    print("dataResult.data---- ${dataResult.data["data"]}");
    return InitSessionModel.fromJson(dataResult.data["data"]);
  }

  Future<InsertSessionModel> addMessages(String message, int sessionsId) async {
    var createdUserID = SPref.instance.get(AppKey.staffId);
    Map<String, dynamic> formData = {
      "content": "$message",
      "createdUserID": createdUserID,
      "createdUserType": "NormalUser",
      "messageType": "Text"
    };
    print("${jsonEncode(formData)}");
    print("$sessionsId");
    var dataResult =
        await dio.post("sessions/$sessionsId/messages", data: formData);
    print("dataResult.data---- ${dataResult.data["data"]}");
    return InsertSessionModel.fromJson(dataResult.data["data"]);
  }

  closeMessages(int sessionsId) async {
    var dataResult = await dio.post("sessions/$sessionsId/makeItFinished");
    print("dataResult.data---- ${dataResult.data["data"]}");
  }

  Future<List<MessageModel>> getAllMessage(
      {required int sessionsId, int pageIndex = 0}) async {
    var dataResult = await dio
        .get("sessions/$sessionsId/messages?pageSize=10&pageindex=$pageIndex");
    print("dataResult.data---- ${dataResult.data["data"]}");
    if (dataResult.data["data"] != null &&
        (dataResult.data["data"] as List).length > 0) {
      return List.from((dataResult.data["data"] as List)
          .map((e) => MessageModel.fromJson(e)));
    }
    return [];
  }

  Future<List<InitSessionModel>> getSessionsByUser({int pageIndex = 0}) async {
   try{
     var userId = SPref.instance.get(AppKey.staffId);
     print("getSessionsByUser---- $userId");
     var dataResult = await dio
         .get("sessions/?pageSize=10&pageindex=$pageIndex&createdID=$userId");
     if (dataResult.data["data"] != null &&
         (dataResult.data["data"] as List).length > 0) {
       return List.from((dataResult.data["data"] as List)
           .map((e) => InitSessionModel.fromJson(e)));
     }
     return [];
   }catch(error){
     print("getSessionsByUser------ $error");
     return [];
   }
  }
}
