import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as ig;
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/config/backend.dart';
import 'package:viettel_app/services/spref.dart';
import 'package:viettel_app/shared/helper/dialogs.dart';
import 'package:http/http.dart' as http;

import '../../config/theme/size-constant.dart';
import '../../config/theme/style-constant.dart';

showSelectImage(
    {required BuildContext context, required Function(String) callBack}) {
  final _picker = ImagePicker();

  Get.bottomSheet(
      IntrinsicHeight(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                Get.back();
                WaitingDialog.show(context);
                final XFile? pickedFile = await _picker.pickImage(
                    imageQuality: 50, source: ImageSource.gallery);
                print("gallery path - ${pickedFile?.path}");
                uploadImage(pickedFile?.path ?? "", onUpdateImage: (value) {
                  print("gallery - $value");
                  WaitingDialog.turnOff();
                  if (value != null) callBack.call(value);
                });
                // print("gallery - ${pickedFile?.path}");
              },
              child: Padding(
                padding: EdgeInsets.all(kConstantPadding),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_album,
                      size: 40,
                    ),
                    SizedBox(width: kConstantPadding),
                    Text(
                      'Thư viện ảnh',
                      style: StyleConst.boldStyle(fontSize: titleSize),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Get.back();
                WaitingDialog.show(context);

                final XFile? pickedFile = await _picker.pickImage(
                    imageQuality: 50, source: ImageSource.camera);

                print("gallery path - ${pickedFile?.path}");
                uploadImage(pickedFile?.path ?? "", onUpdateImage: (value) {
                  print("gallery - $value");
                  WaitingDialog.turnOff();
                  if (value != null) callBack.call(value);
                });
              },
              child: Padding(
                padding: EdgeInsets.all(kConstantPadding),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 40,
                    ),
                    SizedBox(width: kConstantPadding),
                    Text(
                      'Máy ảnh',
                      style: StyleConst.boldStyle(fontSize: titleSize),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white);
}

Future uploadImage(String path, {Function(String?)? onUpdateImage}) async {
  final uri = 'https://app-trung-mua.mismart.ai/api/file/upload-no-save';
  String xToken = SPref.instance.get(AppKey.xToken);
  final imgurService =
      ig.Imgur(ig.Authentication.fromClientId('317d13ba79b0825')).image;
  if (path.isNotEmpty) {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.files.add(
      await http.MultipartFile.fromPath('upload', path)
    );
    request.headers.clear();
    request.headers.addAll({
      "Accept": "application/json",
      "$BACKEND_TOKEN_HEADER": xToken,
    });
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    if(responseData["link"] != null)
      onUpdateImage!.call(responseData["link"]);
  }
}
