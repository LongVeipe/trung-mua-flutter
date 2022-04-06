import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/shared/helper/permission.dart';
import 'package:viettel_app/src/information/information_personal_page.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login/login_page.dart';

import 'services/firebase/firebase_auth.dart';
import 'services/firebase/firebase_messages.dart';
import 'services/spref.dart';
import 'src/camera_search/controllers/in_app_purchase_controller.dart';
import 'src/home/nagivator_bottom_page.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter/foundation.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    if (defaultTargetPlatform == TargetPlatform.android) {
      // For play billing library 2.0 on Android, it is mandatory to call
      // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
      // as part of initializing the app.
      InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    }
    await permissionInit();
    await SPref.init();
    cameras = await availableCameras();
    await ConfigFirebaseMessages.init();
    runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConfigFirebaseMessages.initEvent(context);
    AuthController authController = Get.put(AuthController());
    ConfigFirebaseAuth.intent.auth.authStateChanges().listen((user) {
      if (user != null) {
        print("authStateChanges---${user.phoneNumber}");
      } else {
        print("authStateChanges---null");
      }
    });
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkFirst(),
    );
  }

  Widget checkFirst() {
    String? xToken = SPref.instance.get(AppKey.xToken);
    String? staffId = SPref.instance.get(AppKey.staffId);
    AuthController authController = Get.find<AuthController>();
    if (xToken != null && xToken.isNotEmpty) {
      if (staffId != null && staffId.isNotEmpty)
        return FutureBuilder(
            future: authController.userGetMe(),
            builder: (BuildContext context, AsyncSnapshot snapshot ) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                );
              // if (authController.userCurrent.id == null) {
              //   return LoginPage();
              // }
              // authController.init();
              return NavigatorBottomPage();
            }
        );
    }
    return NavigatorBottomPage();
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}