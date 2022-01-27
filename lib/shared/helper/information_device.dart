import 'package:platform_device_id/platform_device_id.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/services/spref.dart';

getInfoDevice() async {
  try {
    var deviceId = await PlatformDeviceId.getDeviceId;
    print("deviceId----- $deviceId");
    await SPref.instance.set(AppKey.deviceId, deviceId ?? "");
    // print("deviceId-2 ${SPref.instance.get(AppKey.deviceId)}");
  } catch (error) {
    throw error;
  }
}