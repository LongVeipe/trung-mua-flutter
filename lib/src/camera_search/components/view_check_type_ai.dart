import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/camera_search/controllers/camera_search_controller.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';

import '../../../export.dart';

_ViewTypeAI viewTypeAI = _ViewTypeAI();

class _ViewTypeAI {
  int valDisease = 0;
  int valPlant = 2;
  List<TypeClass> _type = [
    TypeClass(name: "Sâu hại", type: "Worm", groupName: "Sâu bệnh", id: ""),
    TypeClass(name: "", type: "", groupName: "", id: "")
  ];

  List<TypeClass> listData = [
    TypeClass(name: "Sâu hại", type: "Worm", groupName: "Sâu bệnh", id: ""),
    TypeClass(name: "Dịch bệnh", type: "Disease", groupName: "Sâu bệnh", id :""),
  ];

  _ViewTypeAI() {
    getAllPlant();
  }

  getAllPlant() {
    var result = Get.find<AuthController>().listPlant;
    _type[1] = TypeClass(
        name: result.first.name ?? "",
        type: removeUnicode(result.first.name ?? ""),
        groupName: "Cây trồng",
        id: result.first.id ?? "",
    );

    for (var value in result) {
      listData.add(TypeClass(
          name: value.name ?? "",
          type: removeUnicode(value.name ?? ""),
          groupName: "Cây trồng", id: value.id ?? ""),
      );
    }
  }

  showSelectedType(BuildContext context, Function(List<TypeClass>) callBack) {
    StreamController streamController = StreamController();
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: StreamBuilder<dynamic>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          child: SingleChildScrollView(
                              child: listWidget(streamController))),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16 + MediaQuery.of(context).padding.bottom,
                            top: 16),
                        child: WidgetButton(
                          text: "Xác nhận",
                          textColor: Colors.white,
                          onTap: () {
                            streamController.close();
                            Navigator.of(context).pop();
                            callBack.call(_type);
                          },
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }

  Widget listWidget(StreamController streamController) {
    String nameGroupTemp = "";
    List<Map<String, dynamic>> listGroup = [];

    for (var i = 0; i < listData.length; i++) {
      if (nameGroupTemp.contains(listData[i].groupName)) {
        listGroup
            .firstWhere((iii) => iii["groupName"] == listData[i].groupName)[
                "listWidget"]
            ?.add(
              itemWidgetType(streamController, i, listData[i].groupName),
            );
      } else {
        nameGroupTemp += "-${listData[i].groupName}";
        listGroup.add({
          "groupName": listData[i].groupName,
          "listWidget": [
            itemWidgetType(streamController, i, listData[i].groupName),
          ]
        });
      }
    }
    return Column(
      children: List.generate(listGroup.length, (index) {
        var data = (listGroup[index]["listWidget"] as List)
            .map<Widget>((e) => e)
            .toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                "${listGroup[index]["groupName"]}",
                style: StyleConst.boldStyle(fontSize: titleSize),
              ),
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data)
          ],
        );
      }),
    );
  }

  Widget itemWidgetType(
      StreamController streamController, int i, String groupValue) {
    return GestureDetector(
      onTap: () {
        if (groupValue == "Cây trồng") {
          valPlant = i;
          _type[1] = listData[i];
        } else {
          valDisease = i;
          _type[0] = listData[i];
        }
        streamController.sink.add(i);
      },
      child: ListTile(
        title: Text(
          "${listData[i].name}",
          style: StyleConst.regularStyle(),
        ),
        leading: Radio(
          value: i,
          activeColor: ColorConst.primaryColor,
          groupValue: groupValue == "Cây trồng" ? valPlant : valDisease,
          onChanged: (value) {
            print(value);
            if (groupValue == "Cây trồng") {
              valPlant = i;
              _type[1] = listData[i];
            } else {
              valDisease = i;
              _type[0] = listData[i];
            }
            streamController.sink.add(i);
          },
        ),
      ),
    );
  }
}

class TypeClass {
  final String name;
  final String type;
  final String groupName;
  final String id;

  TypeClass({
    required this.name,
    required this.type,
    required this.groupName,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['groupName'] = groupName;
    return map;
  }
}

removeUnicode(String text) {
  List<String> arr1 = [
    "á",
    "à",
    "ả",
    "ã",
    "ạ",
    "â",
    "ấ",
    "ầ",
    "ẩ",
    "ẫ",
    "ậ",
    "ă",
    "ắ",
    "ằ",
    "ẳ",
    "ẵ",
    "ặ",
    "đ",
    "é",
    "è",
    "ẻ",
    "ẽ",
    "ẹ",
    "ê",
    "ế",
    "ề",
    "ể",
    "ễ",
    "ệ",
    "í",
    "ì",
    "ỉ",
    "ĩ",
    "ị",
    "ó",
    "ò",
    "ỏ",
    "õ",
    "ọ",
    "ô",
    "ố",
    "ồ",
    "ổ",
    "ỗ",
    "ộ",
    "ơ",
    "ớ",
    "ờ",
    "ở",
    "ỡ",
    "ợ",
    "ú",
    "ù",
    "ủ",
    "ũ",
    "ụ",
    "ư",
    "ứ",
    "ừ",
    "ử",
    "ữ",
    "ự",
    "ý",
    "ỳ",
    "ỷ",
    "ỹ",
    "ỵ"
  ];
  List<String> arr2 = [
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
    "d",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "e",
    "i",
    "i",
    "i",
    "i",
    "i",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "o",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "u",
    "y",
    "y",
    "y",
    "y",
    "y",
  ];
  for (int i = 0; i < arr1.length; i++) {
    text = text.toLowerCase();
    text = text.replaceAll(arr1[i], arr2[i]);
    text = text.replaceAll(" ", "-");
  }
  return text;
}
