import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class PreviewWindowManager {
  static Future<void> initialize(Size size) async {
    WidgetsFlutterBinding.ensureInitialized();

    await windowManager.ensureInitialized();

    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    final height =
        view.physicalSize.height - view.padding.top - view.padding.bottom;

    final windowOptions = WindowOptions(
      center: true,
      size: Size(size.width, height),
      backgroundColor: Colors.transparent,
    );

    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);

    await windowManager.waitUntilReadyToShow(windowOptions);
    await windowManager.show();
  }

  static bool get isMobile {
    switch (defaultTargetPlatform) {
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      default:
        return false;
    }
  }
}
