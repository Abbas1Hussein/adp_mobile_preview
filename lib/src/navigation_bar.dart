import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconTheme(
        data: const IconThemeData(size: 15.0, color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: 'finish',
              child: GestureDetector(
                onTap: windowManager.close,
                child: const Icon(Icons.close),
              ),
            ),
            Tooltip(
              message: 'minimize',
              child: GestureDetector(
                onTap: windowManager.minimize,
                child: const Icon(Icons.minimize),
              ),
            ),
            FutureBuilder<bool>(
              future: windowManager.isMaximized(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return Tooltip(
                    message: 'unMaximize',
                    child: GestureDetector(
                      onTap: () {
                        windowManager.unmaximize();
                        setState(() {});
                      },
                      child: const Icon(Icons.fullscreen_exit),
                    ),
                  );
                }
                return Tooltip(
                  message: 'maximized',
                  child: GestureDetector(
                    onTap: () {
                      windowManager.maximize();
                      setState(() {});
                    },
                    child: const Icon(Icons.fullscreen),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
