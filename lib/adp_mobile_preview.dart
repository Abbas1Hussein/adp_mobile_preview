library adp_mobile_preview;

import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'src/core/init.dart';
import 'src/preview.dart';

export 'package:device_frame/device_frame.dart' show GenericPhoneFramePainter;

export 'src/core/common/devices.dart';

class AdaptiveMobilePreview extends StatelessWidget {
  const AdaptiveMobilePreview({
    super.key,
    required this.child,
    required this.type,
  });

  /// The child widget to be rendered within the mobile preview [AdpApp].
  final Widget child;

  /// The device information specifying the type of mobile device to preview.
  ///
  /// For example:
  ///
  /// ```
  /// AdaptiveMobilePreview(
  ///   type: PlatformRuining.targetPlatform == MobileTargetPlatform.android
  ///       ? DevicesType.android.samsungGalaxyA50
  ///       : DevicesType.iOS.iPhone13Mini,
  ///   child: AdpApp(),
  /// )
  /// ```
  final DeviceInfo type;

  @override
  Widget build(BuildContext context) {
    /// Checks if the current platform is a real mobile device (Android or iOS) OR Web.
    /// If so, returns the child widget directly (i.e., AdpApp).
    if (PreviewWindowManager.isMobile || kIsWeb) return child;

    return PreviewWidget(type: type, child: child);
  }
}
