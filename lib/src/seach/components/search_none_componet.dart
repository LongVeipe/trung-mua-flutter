import 'package:flutter/material.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/size-constant.dart';
import 'package:viettel_app/config/theme/style-constant.dart';

class SearchNoneComponent extends StatelessWidget {
  const SearchNoneComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(AssetsConst.iconSearchNone),
          width: 105,
          height: 105,
        ),
        SizedBox(
          height: 49,
        ),
        Text(
          "Không tìm thấy kết quả",
          style: StyleConst.boldStyle(fontSize: titleSize),
        ),
        SizedBox(height: 13,),
        Text(
          "Nội dung tìm kiếm không có. Bạn vui lòng thử lại.",
          style: StyleConst.regularStyle( ),
        ),
      ],
    );
  }
}
