import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AdaptiveMobilePreviewManager {
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
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.setResizable(false);
    await windowManager.waitUntilReadyToShow(windowOptions);
    await windowManager.show();
    await windowManager.focus();
  }
}
