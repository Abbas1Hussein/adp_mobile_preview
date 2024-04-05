import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart' hide NavigationBar;
import 'package:window_manager/window_manager.dart';

import 'core/init.dart';
import 'fake_android_status_bar.dart';
import 'fake_ios_status_bar.dart';
import 'navigation_bar.dart';

class PreviewWidget extends StatefulWidget {
  const PreviewWidget({ super.key, required this.type, required this.child });

  final Widget child;
  final DeviceInfo type;

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  bool useVirtualKeyboard = false;
  bool isFrameVisible = true;

  TextDirection textDirection = TextDirection.rtl;

  @override
  void initState() {
    PreviewWindowManager.initialize(widget.type.screenSize);
    super.initState();
  }

  bool get isAndroid =>
      widget.type.identifier.platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
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
              _buildFrameVisibility(),
              _buildDragHandleIcon(),
            ],
          ),
          Flexible(
            child: DeviceFrame(
              device: widget.type,
              isFrameVisible: isFrameVisible,
              orientation: MediaQuery.orientationOf(context),
              screen: VirtualKeyboard(
                isEnabled: useVirtualKeyboard,
                child: Column(
                  children: [
                    _buildFakeStatusBar(),
                    Expanded(child: widget.child),
                  ],
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

  Widget _buildFrameVisibility() {
    return _buildButtonIcon(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFrameVisible = !isFrameVisible;
          });
        },
        child: isFrameVisible
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
      ),
    );
  }

  Widget _buildButtonIcon({ required Widget child }) {
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

  Widget _buildFakeStatusBar() =>
      isAndroid ? const FakeAndroidStatusBar() : const FakeIOSStatusBar();
}
