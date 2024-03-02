import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart' hide NavigationBar;
import 'package:window_manager/window_manager.dart';

import 'core/init.dart';
import 'fake_android_status_bar.dart';
import 'fake_ios_status_bar.dart';
import 'navigation_bar.dart';

class AdaptiveMobilePreview extends StatefulWidget {
  const AdaptiveMobilePreview({
    super.key,
    required this.type,
    required this.child,
  });

  final DeviceInfo type;
  final Widget child;

  @override
  State<AdaptiveMobilePreview> createState() => _AdaptiveMobilePreviewState();
}

class _AdaptiveMobilePreviewState extends State<AdaptiveMobilePreview> {
  bool useVirtualKeyboard = false;
  TextDirection textDirection = TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    AdaptiveMobilePreviewManager.initialize(widget.type.screenSize);
  }

  @override
  Widget build(BuildContext context) {
    final isAndroid = widget.type.identifier.platform == TargetPlatform.android;

    return Directionality(
      textDirection: textDirection,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildNavigationBar(),
              _buildVirtualKeyboardToggle(),
              _buildDirectionIcon(),
              _buildDragHandleIcon(),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DeviceFrame(
                device: widget.type,
                orientation: MediaQuery.orientationOf(context),
                screen: VirtualKeyboard(
                  isEnabled: useVirtualKeyboard,
                  child: Column(
                    children: [
                      _buildFakeStatusBar(isAndroid),
                      Expanded(child: widget.child),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return SizedBox(
      width: 45.0,
      height: 200,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return const Card(
                color: Colors.transparent,
                child: NavigationBar(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildVirtualKeyboardToggle() {
    return _buildButtonIcon(
      child: GestureDetector(
        onTap: () => setState(() => useVirtualKeyboard = !useVirtualKeyboard),
        child: useVirtualKeyboard
            ? const Icon(Icons.keyboard_hide)
            : const Icon(Icons.keyboard),
      ),
    );
  }

  Widget _buildDragHandleIcon() {
    return _buildButtonIcon(
      child: GestureDetector(
        onPanStart: (details) => windowManager.startDragging(),
        child: const Icon(Icons.swipe_rounded),
      ),
    );
  }

  Widget _buildDirectionIcon() {
    return _buildButtonIcon(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (textDirection == TextDirection.rtl) {
              textDirection = TextDirection.ltr;
            } else {
              textDirection = TextDirection.rtl;
            }
          });
        },
        child: const Icon(Icons.rtt_rounded),
      ),
    );
  }

  Widget _buildButtonIcon({required Widget child}) {
    return SizedBox(
      width: 45,
      height: 50,
      child: Card(
        color: Colors.transparent,
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: child,
        ),
      ),
    );
  }

  Widget _buildFakeStatusBar(bool isAndroid) =>
      isAndroid ? const FakeAndroidStatusBar() : const FakeIOSStatusBar();
}
