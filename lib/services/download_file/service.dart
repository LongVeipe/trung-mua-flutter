import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viettel_app/export.dart';

import 'path_file_local.dart';

class Service {
  static Future<File?> downloadFile(String link,
      {Function(double)? onReceiveProgress, String? nameFile}) async {
    try {
      // print("$link");
      final fileName = nameFile ?? (link.split('/').last);
      // print("fileName----- ${fileName}");
      final tempDir =
          await PathFileLocals().getPathLocal(ePathType: EPathType.Download);
      File file = new File("${tempDir?.path}/$fileName");
      print("file----- ${file.path}");

      if (await PathFileLocals().checkExistFile(path: file.path) == true &&
          file.lengthSync() > 0) {
        // await file.create();
        print(file.path);
        onReceiveProgress?.call(1);
        return file;
        // File file = new File("${tempPath}/${fileName}");
      }
      var dataResult = await Dio().get(link,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0), onReceiveProgress: (received, total) {
        double dataProgress = (received / total * 100);
        onReceiveProgress?.call(dataProgress / 100);
        // print(dataProgress/100);
      });
      print(dataResult.data);
      var status = await Permission.storage.status;
      print("status-----------${status.isGranted}");
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await file.writeAsBytes(dataResult.data);
      // }
      print("file-------${file.path}");

      return file;
    } catch (error) {
      print(error);
      showSnackBar(title: "Thông báo", body: "Tải không thành công.",backgroundColor: Colors.red);
      return null;
    }
  }

  static Future<File?> downloadCacheImage(String link,{String? nameFile}) async {
    try {
      // print("$link");
      final fileName = nameFile ?? (link.split('/').last);
      // print("fileName----- ${fileName}");
      final tempDir =
      await PathFileLocals().getPathLocal(ePathType: EPathType.cache);
      File file = new File("${tempDir?.path}/$fileName");
      // print("file----- ${file.path}");

      if (await PathFileLocals().checkExistFile(path: file.path) == true &&
          file.lengthSync() > 0) {
        // await file.create();
        print(file.path);
        return file;
        // File file = new File("${tempPath}/${fileName}");
      }
      var dataResult = await Dio().get(link,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0), onReceiveProgress: (received, total) {
            double dataProgress = (received / total * 100);
            // print(dataProgress/100);
          });
      print(dataResult.data);
      var status = await Permission.storage.status;
      print("status-----------${status.isGranted}");
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await file.writeAsBytes(dataResult.data);

      return file;
    } catch (error) {
      print("downloadCacheImage--- error: $error");
      // showSnackBar(title: "Thông báo", body: "Tải không thành công.",backgroundColor: Colors.red);
      return null;
    }
  }


}
