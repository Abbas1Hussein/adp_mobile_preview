import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _uiStyleNotch = TextStyle(
  fontFamily: '.SF UI',
  fontSize: 11.0,
  color: CupertinoColors.systemBackground,
  fontWeight: FontWeight.w600,
);

class FakeIOSStatusBar extends StatelessWidget {
  const FakeIOSStatusBar({
    super.key,
    this.roundedCorners = true,
    this.height = 15.0,
  });

  final double height;
  final bool roundedCorners;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay.now();
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${time.hourOfPeriod}:${time.minute} ${time.period.name}'
                .toUpperCase(),
            style: _uiStyleNotch,
          ),
          Expanded(child: Container()),
          SizedBox(
            height: 11.0,
            child: Image.asset(
              'assets/ios-bar-white.png',
              package: 'adp_mobile_preview',
            ),
          ),
        ],
      ),
    );
  }
}
