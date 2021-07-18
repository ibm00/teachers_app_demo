import 'package:device_info/device_info.dart';

class DeviceInfoService {
  static Future<String> getMobileId() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    return "$manufacturer/$model";
    // Android 9 (SDK 28), Xiaomi Redmi Note 7
  }
}
