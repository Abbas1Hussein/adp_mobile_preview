import 'package:device_frame/device_frame.dart';
import 'package:flutter/widgets.dart';

class DevicesType extends DeviceInfo {
  factory DevicesType._() => DevicesType._();

  static const iOS = Devices.ios;
  static const android = Devices.android;

  static DeviceInfo genericPhone({
    required String id,
    required String name,
    required Size screenSize,
    bool isAndroid = true,
    EdgeInsets safeAreas = EdgeInsets.zero,
    EdgeInsets rotatedSafeAreas = EdgeInsets.zero,
    double pixelRatio = 2.0,
    GenericPhoneFramePainter framePainter = const GenericPhoneFramePainter(),
  }) {
    return DeviceInfo.genericPhone(
      platform: isAndroid ? TargetPlatform.android : TargetPlatform.iOS,
      id: id,
      name: name,
      screenSize: screenSize,
      safeAreas: safeAreas,
      rotatedSafeAreas: rotatedSafeAreas,
      pixelRatio: pixelRatio,
      framePainter: framePainter,
    );
  }
}
