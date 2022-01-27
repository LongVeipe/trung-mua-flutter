import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viettel_app/shared/helper/print_log.dart';
import '../../config/backend.dart';
import '../../src/notification/controllers/notification_controller.dart';
import '../../src/notification/detail_notification_page.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../config/app_key.dart';
import '../../export.dart';
import '../../services/spref.dart';
import 'notify_event.dart';

class ConfigFirebaseMessages {
  static String _vapidKey =
      "AAAAkuKrbRY:APA91bE6jnGFvHNej60zufyumNI8MnHcjqHPVukMjs_vlVxtya-W2c4WvrGZqHINm7svbfmWsvnptyr74qOo6NVVsROrBR2nAyYeuC54EIC4coYiOxdoggY4nKZGbDUmhGc8-kMF5nxV";

  static init() async {
    PermissionHelper.init();

    // WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // FirebaseCrashlytics.instance.crash();
    // if (kDebugMode) {
    //   // Force disable Crashlytics collection while doing every day development.
    //   // Temporarily toggle this to true if you want to test crash reporting in your app.
    //   await FirebaseCrashlytics.instance
    //       .setCrashlyticsCollectionEnabled(false);
    // } else {
    //   // Handle Crashlytics enabled status when not in Debug,
    //   // e.g. allow your users to opt-in to crash reporting.
    // }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("mcom.app.trungmua");
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await getToken();

    RemoteConfig remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    // remoteConfig.setDefaults(<String, dynamic>{
    //   'backend': 'host default',
    // });
    RemoteConfigValue(null, ValueSource.valueStatic);
    bool updated = await remoteConfig.fetchAndActivate();

    // String httpKey = "http_product";
    // String wssKey = "wss_product";
    String httpKey = "http_dev";
    String wssKey = "wss_dev";

    if (updated) {
      // the config has been updated, new parameter values are available.
      print("TrungMua--BACKEND_HTTP1----- ${remoteConfig.getString(httpKey)}");
      print("TrungMua--BACKEND_WSS1----- ${remoteConfig.getString(wssKey)}");
      if (remoteConfig.getString(httpKey).isNotEmpty) {
        BackendHost.BACKEND_HTTP = remoteConfig.getString(httpKey);
      }
      if (remoteConfig.getString(wssKey).isNotEmpty) {
        BackendHost.BACKEND_WSS = remoteConfig.getString(wssKey);
      }
    } else {
      // the config values were previously updated.
      print("TrungMua--BACKEND_HTTP2----- ${remoteConfig.getString(httpKey)}");
      print("TrungMua--BACKEND_WSS2----- ${remoteConfig.getString(wssKey)}");
      if (remoteConfig.getString(httpKey).isNotEmpty) {
        BackendHost.BACKEND_HTTP = remoteConfig.getString(httpKey);
      }
      if (remoteConfig.getString(wssKey).isNotEmpty) {
        BackendHost.BACKEND_WSS = remoteConfig.getString(wssKey);
      }
    }
  }

  static initEvent(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then((value) async {
      printLog("getInitialMessage ------------ ${value?.data["body"]}");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        printLog("onMessage------------ ${message.data}");
        // await  _showNotificationCustomSound();
        NotifyEvent.callListener(key: "NotificationPage", dataValue: "");
        showSnackBar(
            title: "${message.notification?.title ?? ""}",
            body: "${message.notification?.body ?? ""}");
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("onBackgroundMessage-----");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      printLog(
          'A new onMessageOpenedApp event was published!!!!!!!!!!!!!!!!!!!!!!!!!!');
      printLog("message.data---${message.data["notifyId"]}");
      printLog("message.data---${message.data}");
      Get.put(NotificationController());
      Get.to(DetailNotificationPage(
        id: message.data["notifyId"],
      ));
    });
  }

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  static getToken() async {
    await FirebaseMessaging.instance
        .getToken(vapidKey: _vapidKey)
        .then((value) async {
      await SPref.instance.set(AppKey.deviceToken, value ?? "");
      printLog("firebase token: $value");
      return value;
    });
  }

  static refreshToken() async {
    printLog(
        "refreshToken token: --------------------------------------------------");
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      printLog("refresh token: $event");
    });
  }
}

class PermissionHelper {
  static init() async {
    if (await Permission.notification.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses =
          await [Permission.notification].request();
      print("statuses[Permission.location]-----");
    }
  }
}
