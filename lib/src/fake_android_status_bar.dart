import 'dart:math';

import 'package:flutter/material.dart';

const style = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: 11.0,
  color: Colors.white,
);

class FakeAndroidStatusBar extends StatelessWidget {
  const FakeAndroidStatusBar({
    super.key,
    this.horizontalPadding = 8.0,
    this.backgroundColor,
    this.height = 15.0,
  });

  final double height;
  final double horizontalPadding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    const padding = 2.0;
    final iconSize = min(height - padding * 2, 22.0);

    final time = TimeOfDay.now();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      height: height,
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Text(
            '${time.hourOfPeriod}:${time.minute} ${time.period.name}'.toUpperCase(),
            style: style,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Icon(
              Icons.network_wifi,
              color: Colors.white,
              size: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Icon(
              Icons.battery_full,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
