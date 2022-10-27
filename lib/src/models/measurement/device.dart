// ignore_for_file: depend_on_referenced_packages

import 'package:device_info_plus/device_info_plus.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:platform/platform.dart';

import '../../sdk_errors.dart';

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  static const String manufacturerApple = 'Apple';
  static const String deviceTypeAndroid = "android";
  static const String deviceTypeIos = "ios";

  final String? manufacturer;
  final String? model;
  final String? os;
  final String? type;

  Device({
    this.manufacturer,
    this.model,
    this.os,
    this.type,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  static Future<Device> getDeviceInfo(bool suppressPlatformCheckError) async {
    Future<Device> getIosDevice(DeviceInfoPlugin deviceInfo) async {
      final iosInfo = await deviceInfo.iosInfo;

      return Device(
        os: iosInfo.systemVersion,
        model: iosInfo.localizedModel,
        manufacturer: manufacturerApple,
        type: deviceTypeIos,
      );
    }

    Future<Device> getAndroidDevice(DeviceInfoPlugin deviceInfo) async {
      final androidInfo = await deviceInfo.androidInfo;

      return Device(
        os: androidInfo.version.release,
        model: androidInfo.model,
        manufacturer: androidInfo.manufacturer,
        type: deviceTypeAndroid,
      );
    }

    final deviceInfo = DeviceInfoPlugin();
    const platform = LocalPlatform();

    if (platform.isAndroid) {
      return await getAndroidDevice(deviceInfo);
    } else if (platform.isIOS) {
      return await getIosDevice(deviceInfo);
    } else {
      if (!suppressPlatformCheckError) {
        // => suppress unsupported platform error in order to test
        // postMeasurement without mocking of the platform
        throw SdkError(errorBody: "Platform not supported");
      } else {
        return Device();
      }
    }
  }
}
