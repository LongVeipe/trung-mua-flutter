import 'package:flutter/material.dart';

import '../list_result_page.dart';

class WidgetIconBackPage  extends StatelessWidget {
  const WidgetIconBackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListResultPage.countPage>1? GestureDetector(
        onTap: (){
          for(int i=0;i<ListResultPage.countPage;i++){
            Navigator.of(context).pop();
          }
          ListResultPage.countPage=0;
        },
        child: Icon(Icons.clear)):SizedBox();
  }
}
