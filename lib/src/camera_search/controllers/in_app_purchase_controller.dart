import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../shared/helper/print_log.dart';
import 'package:in_app_purchase_ios/in_app_purchase_ios.dart';
import 'package:in_app_purchase_ios/store_kit_wrappers.dart';

import 'consumable_store.dart';

class InAppPurchaseController extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _isAvailable = false;
  final List<String> myProductId = ["scan_ai"];
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];
  List<String> consumables = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });

    _isAvailable = await _inAppPurchase.isAvailable();
    if (_isAvailable) {
      consumables = await ConsumableStore.load();
      await getAllProducts();
    }
  }

  getAllProducts() async {
    try {
      Set<String> ids = Set.from(myProductId);
      if (Platform.isIOS) {
        var iosPlatformAddition = _inAppPurchase
            .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
        await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
      }
      await _inAppPurchase.restorePurchases();
      await _inAppPurchase.queryProductDetails(ids).then((value) {
        products = value.productDetails;
        update();
      });
    } catch (error) {
      printLog(error.toString());
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    // if (purchaseDetails.productID == myProductId) {
    await ConsumableStore.clear();
    await ConsumableStore.save(purchaseDetails.productID);
    consumables = await ConsumableStore.load();
    printLog("consumables---${jsonEncode(consumables)}");
    // setState(() {
    //   _purchasePending = false;
    //   _consumables = consumables;
    // });
    // }
    // else {
    //   // setState(() {
    //     purchases.add(purchaseDetails);
    //     // _purchasePending = false;
    //   // });
    // }
    purchases.add(purchaseDetails);
    update();
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
    });
    update();
  }

  buyProduct(ProductDetails productDetails) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
