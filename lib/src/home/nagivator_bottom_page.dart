import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/config/theme/assets-constant.dart';
import 'package:viettel_app/config/theme/color-constant.dart';
import 'package:viettel_app/shared/tabbar/bottomnavybar_item.dart';
import 'package:viettel_app/shared/tabbar/custom_animated_bottombar.dart';
import 'package:viettel_app/src/feedback/feedback_page.dart';
import 'package:viettel_app/src/library/library_page.dart';
import 'package:viettel_app/src/post/list_posts_page.dart';

import 'home_page.dart';

class NavigatorBottomPage extends StatefulWidget {
  const NavigatorBottomPage({Key? key}) : super(key: key);

  @override
  _NavigatorBottomPageState createState() => _NavigatorBottomPageState();
}

class _NavigatorBottomPageState extends State<NavigatorBottomPage> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  final _activeColor = ColorConst.primaryColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Get.put(TinTucController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 79 - 40),
            child: getBody(),
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildBottomBar())
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    double sizeIcon = 16;

    return CustomAnimatedBottomBar(
      containerHeight: 109,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) async{
        switch (index) {
          case 1:
            Get.to(ListTinTucPage());
            break;
          case 2:
            // WaitingDialog.show(context);
            // try {
            //   await Get.find<SupportController>().initSupport([]);
            // } catch (error) {
            //   print(error);
            // }
            // WaitingDialog.turnOff();
            // Get.to(SupportPage());
            Get.to(FeedBackPage());

            break;
          case 3:
            Get.to(LibraryPage());
            break;
          default:
            setState(() => _currentIndex = index);
            break;
        }
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: ImageIcon(
            AssetImage(AssetsConst.iconHome),
            size: sizeIcon,
          ),
          title: Text('Trang chủ'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: ImageIcon(
            AssetImage(AssetsConst.iconTinTuc),
            size: sizeIcon,
          ),
          title: Text('Tin tức'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: ImageIcon(
            AssetImage(AssetsConst.iconHoTro),
            size: sizeIcon,
          ),
          title: Text(
            'Góp ý',
          ),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: ImageIcon(
            AssetImage(AssetsConst.iconThuVien),
            size: sizeIcon,
          ),
          title: Text('Thư viện'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      Container(
        alignment: Alignment.center,
        child: Text(
          "tin tức",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Hỗ trợ",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Thư viện",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
