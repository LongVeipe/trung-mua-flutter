// import 'package:flutter/material.dart';
// import 'package:viettel_app/config/theme/assets-constant.dart';
// import 'package:viettel_app/config/theme/style-constant.dart';
// import 'package:viettel_app/export.dart';
// import 'package:viettel_app/src/components/widget_container_count_slider.dart';
//
// import 'information_personal_page.dart';
//
// class FlashScreenPage extends StatefulWidget {
//   const FlashScreenPage({Key? key}) : super(key: key);
//
//   @override
//   _FlashScreenPageState createState() => _FlashScreenPageState();
// }
//
// class _FlashScreenPageState extends State<FlashScreenPage> {
//   int flashScreenIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width,
//               height: 40,
//             ),
//             Image.asset(
//               AssetsConst.logoFlashScreen,
//               width: 80,
//               height: 80,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 17, bottom: 33),
//               child: Text(
//                 "ỨNG DỤNG SINH VẬT GÂY HẠI\nCHO CÂY TRỒNG",
//                 style: StyleConst.boldStyle(fontSize: titleSize, height: 1.2),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             widgetImage(),
//             Expanded(child: widgetTextBody()),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 WidgetContainerCountSlider(index: 0,currentPos: flashScreenIndex,),
//                 WidgetContainerCountSlider(index: 1,currentPos: flashScreenIndex,),
//                 WidgetContainerCountSlider(index: 2,currentPos: flashScreenIndex,),
//               ],
//             ),
//             SizedBox(
//               height: 49,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 64,left: 64,bottom: 34),
//               child: WidgetButton(
//                 text: "Tiếp theo",
//                 radius: 100,
//                 textColor: Colors.white,
//                 onTap: () {
//                   setState(() {
//                     if (flashScreenIndex >= 2) {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (
//                           _) => InformationPersonalPage(checkFirst: true,)));
//                     } else {
//                       flashScreenIndex += 1;
//                     }
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//   Widget widgetImage() {
//     String image = "";
//     if (flashScreenIndex == 0) image = AssetsConst.imageFlashScreen1;
//     if (flashScreenIndex == 1) image = AssetsConst.imageFlashScreen2;
//     if (flashScreenIndex == 2) image = AssetsConst.imageFlashScreen3;
//     return Image.asset(
//       image,
//       width: 246,
//       height: 246,
//     );
//   }
//
//   Widget widgetTextBody() {
//     String text = "";
//     if (flashScreenIndex == 0) text =
//     "Nhận biết sinh vật gây hại cho cây trồng bằng hình ảnh từ điện thoại di động thông minh";
//     if (flashScreenIndex == 1) text =
//     "Cập nhật tin tức về cây trồng, thời tiết, cơ chế, chính sách nhanh chóng, kịp thời.";
//     if (flashScreenIndex == 2)
//       text = "Hỏi đáp với chuyên gia trong lĩnh vực cây trồng.";
//     return Padding(
//       padding: const EdgeInsets.only(
//           top: 63, bottom: 20, right: 44, left: 44),
//       child: Text(
//         text,
//         style: StyleConst.regularStyle( height: 1.2),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
// }
