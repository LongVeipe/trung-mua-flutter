
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/src/library/components/tabbar_componet.dart';
import 'package:viettel_app/src/seach/controllers/search_controller.dart';

import '../../../export.dart';

class TabBarComponent extends StatefulWidget {
  final List<Widget> listScreen;

  const TabBarComponent({Key? key,required this.listScreen}) : super(key: key);

  @override
  _TabBarComponentState createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent> {
  List<ModelTabBarComponent> listTabBar = [];
  int indexCurrent = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTabBar.add(ModelTabBarComponent(
        title: "Tin tức", index: 0, callBack: callBack));
    listTabBar.add(ModelTabBarComponent(
        title: "Thư viện", index: 1, callBack: callBack));
  }
  void callBack(int value){
    Get.find<SearchController>().indexCurrent=value;
    setState(() {
      indexCurrent=value;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 16),
            child: Row(
              children: List.generate(listTabBar.length,
                      (index) => widgetItemTabBar(listTabBar.elementAt(index))),
            ),
          ),
          widget.listScreen[indexCurrent]
        ],
      ),
    );
  }

  Widget widgetItemTabBar(ModelTabBarComponent data) {
    BorderRadiusGeometry? borderRadius;
    Color textColor=Colors.white;
    Color backgroundColor=ColorConst.white;

    if(data.index==indexCurrent){
      textColor=ColorConst.white;
      backgroundColor=ColorConst.primaryColor;
    }
    else{
      textColor=ColorConst.textPrimary;
      backgroundColor=ColorConst.white;
    }

    if (data.index == 0) {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (data.index == listTabBar.length - 1) {
      borderRadius = BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    } else {
      borderRadius = BorderRadius.circular(0);
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          data.callBack.call(data.index);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: backgroundColor,
              border: Border.all(color: ColorConst.borderInputColor)),
          child: Center(
              child: Text(
                "${data.title}",
                style: StyleConst.boldStyle(color: textColor),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}