import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viettel_app/services/download_file/path_file_local.dart';

import '../../export.dart';

Future<File?> getFileFromAssetsTerm() async {
  var status = await Permission.storage.status;
  print("status-----------${status.isGranted}");
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  String path = "chinhsach.pdf";
  final byteData = await rootBundle.load('assets/temp/$path');
  print("byteData: ${byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)}");
  final tempDir =
  await PathFileLocals().getPathLocal(ePathType: EPathType.Download);
  File file = new File("${tempDir?.path}/$path");
  print("file----- ${file.path}");
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}


showNow(BuildContext context) async{


  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6),
    // background color
    barrierDismissible: false,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {




      // your widget implementation
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: kToolbarHeight / 2, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Điều kiện và điều khoản sử dụng ',
                          style: StyleConst.boldStyle(),
                          softWrap: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white54,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: FutureBuilder<File?>(
                      future:  getFileFromAssetsTerm(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return SizedBox();
                        }
                        return PDFView(
                          filePath: "${snapshot.data?.path}",
                          // "/storage/emulated/0/Download/2021.7.20 - CV phong chong SVGH cay trong vụ He thu - Mua, Thu Dong 2021.pdf",
                          // enableSwipe: true,
                          // swipeHorizontal: false,
                          // autoSpacing: false,
                          pageFling: false,
                          onRender: (_pages) {
                            // setState(() {
                            //   pages = _pages;
                            //   isReady = true;
                            // });
                          },
                          nightMode: false,
                          onError: (error) {
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            print('$page: ${error.toString()}');
                          },
                          onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                          },
                          onPageChanged: (int? page, int? total) {
                            print('page change: $page/$total');
                          },
                        );
                      }),
                )

                // Expanded(
                //   child: SingleChildScrollView(
                //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         SizedBox(
                //           height: 16,
                //         ),
                //         Center(
                //           child: Text(
                //             """CHÍNH SÁCH CỘNG ĐỒNG TRÚNG MÙA""",
                //             style: StyleConst.mediumStyle(),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //         SizedBox(
                //           height: 16,
                //         ),
                //         Text(
                //           "Nội dung bao gồm:"
                //           "\n1/ Định nghĩa về nguyên tắc Cộng đồng Kết nối nông gia"
                //           "\n2/ Các vi phạm nguyên tắc Cộng đồng Kết nối nông gia"
                //           "\n3/ Báo nội dung không phù hợp – vi phạm",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 16),
                //           child: Text(
                //             "---o0o---",
                //             style: StyleConst.mediumStyle(),
                //           ),
                //         ),
                //         Text(
                //           "Các chính sách của CỘNG ĐỒNG TRÚNG MÙA - cộng đồng "
                //           "do Tập đoàn Lộc Trời và Viện Cây Lúa Miền Nam chỉ đạo phát triển, "
                //           "giúp duy trì một cộng đồng an toàn cho mọi người. Hãy xem phần giới "
                //           "thiệu về các quy định và nguyên tắc để đảm bảo kênh của bạn không "
                //           "gặp vấn đề gì.",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         SizedBox(
                //           height: 16,
                //         ),
                //         Text(
                //           "1/ Nguyên tắc cộng đồng của CỘNG ĐỒNG TRÚNG MÙA là gì?",
                //           style: StyleConst.boldStyle(height: 1.5),
                //         ),
                //         Text(
                //           "Bất kỳ người nào sử dụng các nền tảng của CỘNG ĐỒNG BỆNH VIỆN "
                //           "CÂY LÚA đều phải tuân theo Nguyên tắc cộng đồng. Đây là những "
                //           "quy tắc áp dụng trên toàn cầu giúp đảm bảo CỘNG ĐỒNG BỆNH "
                //           "VIỆN CÂY LÚA là nền tảng tốt nhất để mọi người lắng nghe, chia sẻ "
                //           "và cùng nhau xây dựng cộng đồng. Nguyên tắc cộng đồng trình bày"
                //           " các loại nội dung được phép xuất hiện trên CỘNG ĐỒNG KẾT NỐI "
                //           "NÔNG GIA, các nguyên tắc về việc cấm đăng các nội dung như nội "
                //           "dung rác hoặc quấy rối và nhiều quy tắc khác.",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Text(
                //           "CỘNG ĐỒNG BỆNH VIỆN CÂY LÚA sử dụng sự đánh giá của công "
                //           "nghệ và con người để gắn có nội dung không phù hợp và thực thi các "
                //           "nguyên tắc này. Tìm hiểu cách báo cáo nội dung không phù hợp tại đây.",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Text(
                //           "Nếu nhận thấy nội dung của bạn không tuân theo Nguyên tắc cộng "
                //           "đồng, chúng tôi sẽ gửi cho bạn một cảnh báo (đối với lần vi phạm đầu "
                //           "tiên). Lần tiếp theo chúng tôi phát hiện thấy nội dung của bạn vi "
                //           "phạm Nguyên tắc cộng đồng, bạn sẽ phải nhận cảnh cáo. Sau khi nhận cảnh báo:",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 16),
                //           child: Text(
                //             "+ Nếu vi phạm lần nữa thì bạn sẽ nhận một cảnh cáo từ hệ thống "
                //             "đến tài khoản của bạn và không thể tham gia bình luận trong vòng 2 tuần.",
                //             style: StyleConst.regularStyle(height: 1.5),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 16),
                //           child: Text(
                //             "+ Nếu nhận cảnh cáo thứ 3 trong vòng 90 ngày thì tài khoản của bạn sẽ bị khóa vĩnh viễn.",
                //             style: StyleConst.regularStyle(height: 1.5),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 16,
                //         ),
                //         Text(
                //           "2/ Các vi phạm nguyên tắc CỘNG ĐỒNG KẾT NỐI NÔNG GIA.",
                //           style: StyleConst.boldStyle(height: 1.5),
                //         ),
                //         Text(
                //           "- Khoả thân hoặc nội dung khiêu dâm CỘNG ĐỒNG BỆNH VIỆN CÂY LÚA không dành cho nội dung khỏa "
                //           "thân hoặc nội dung khiêu dâm. Nếu chúng tôi tìm thấy hình ảnh hay "
                //           "thông tin bạn đăng, ngay cả khi đó là hình ảnh hay thông tin của "
                //           "chính bạn, chúng tôi sẽlàm việc chặt chẽ với cơ quan thực thi pháp "
                //           "luật để xử lý vi phạm theo quy định pháp luật.",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Text(
                //           "- Nội dung có hại hoặc nguy hiểm, vi phạm pháp luật và đạo đức "
                //           "Không được phép đăng thông tin và hình ảnh khuyến khích người khác làm những việc có thể khiến họ bị tổn thương nặng nề, hoặc "
                //           "thông tin vi phạm pháp luật, đạo đức. Thông tin và hình ảnh cho thấy "
                //           "các hành vi gây hại hoặc nguy hiểm, vi phạm pháp luật, đạo đức "
                //           "chúng tôi có thể xóa ngay hoặc làm việc chặt chẽ với cơ quan thực thi pháp luật, tùy vào mức độ nghiêm trọng",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         SizedBox(
                //           height: 16,
                //         ),
                //         Text(
                //           "3/ Báo nội dung không phù hợp là vi phạm.",
                //           style: StyleConst.boldStyle(height: 1.5),
                //         ),
                //         Text(
                //           "Chúng tôi dựa vào sự trợ giúp của các thành viên trong cộng đồng "
                //           "CỘNG ĐỒNG BỆNH VIỆN CÂY LÚA trong việc báo nội dung mà họ "
                //           "thấy không phù hợp là vi phạm. Người báo nội dung là vi phạm được "
                //           "ẩn danh nên những người khác không thể biết ai đã báo vi phạm.",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Text(
                //           "Nội dung khi bị báo vi phạm sẽ không tự động bị gỡ bỏ. Chúng tôi "
                //           "xem xét nội dung bị báo vi phạm theo các nguyên tắc sau: ",
                //           style: StyleConst.regularStyle(height: 1.5),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 16),
                //           child: Text(
                //             "+ Nội dung vi phạm Nguyên tắc cộng đồng của chúng tôi sẽ bị "
                //             "xóa khỏi CỘNG ĐỒNG KẾT NỐI NÔNG GIA.",
                //             style: StyleConst.regularStyle(height: 1.5),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 16),
                //           child: Text(
                //             "+ Nội dung không phù hợp với pháp luật và đạo đức ở Việt Nam.",
                //             style: StyleConst.regularStyle(height: 1.5),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
