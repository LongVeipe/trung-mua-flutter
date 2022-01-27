import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share/share.dart';
import 'package:viettel_app/export.dart';
import 'package:viettel_app/services/download_file/service.dart';

import 'widget_appbar.dart';

class WidgetPDFView extends StatefulWidget {
  final String url;
  final String name;

  WidgetPDFView({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  _WidgetPDFViewState createState() => _WidgetPDFViewState();
}

class _WidgetPDFViewState extends State<WidgetPDFView>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  StreamController<num> progressStream= StreamController();


  String pathLocal="";

  @override
  void dispose() {
    // TODO: implement dispose
    progressStream.close();
    super.dispose();
  }



  Future<File?> downFile() async {
    try {
      File? file = await Service.downloadFile(widget.url,
          nameFile: widget.name,
          // "https://sonnptnt.hungyen.gov.vn/portal/VanBan/2021-01/d540e9f8da1cc5bdtb02.pdf",
          onReceiveProgress: (value) {
            progressStream.sink.add(value);
          });
      return file;
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitCircle(
      color: ColorConst.primaryColor,
      size: 50.0,
    );

    return Scaffold(
      body: Column(
        children: [
          WidgetAppbar(
            title: "PDF Preview",
            turnOffSearch: true,
            turnOffNotification: true,
            widgetIcons:  widgetIconShare(),
          ),
          Expanded(
            child: FutureBuilder<File?>(
                future: downFile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(child: StreamBuilder<num>(
                      stream: progressStream.stream,
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            spinKit,
                            Text("${((snapshot.data??0)*100).toStringAsFixed(0)}%",style: StyleConst.boldStyle(),)
                          ],
                        );
                      }
                    ));
                  }
                  pathLocal=snapshot.data?.path??"";

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
        ],
      ),
    );
  }


  Widget widgetIconShare(){
    return GestureDetector(
      onTap: (){
        if(pathLocal.isNotEmpty){
          Share.shareFiles([pathLocal], text: widget.name);
        }
      },
      child: Icon(
        Icons.share_outlined,color: ColorConst.textPrimary,
      ),
    );
  }
}
