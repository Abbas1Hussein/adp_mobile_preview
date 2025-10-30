import 'package:adp_mobile/adp_mobile.dart';
import 'package:adp_mobile_preview/adp_mobile_preview.dart';
import 'package:flutter/material.dart';

void main() {
  DefaultsPlatformManager.initialize(
    targetPlatform: MobileTargetPlatform.android,
  );
  runApp(const AdaptiveAppPreview());
}

class AdaptiveAppPreview extends StatefulWidget {
  const AdaptiveAppPreview({super.key});

  @override
  State<AdaptiveAppPreview> createState() => _AdaptiveAppPreviewState();
}

class _AdaptiveAppPreviewState extends State<AdaptiveAppPreview> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveMobilePreview(
      type: adaptiveValue(
        iOS: () => DevicesType.iOS.iPhone13ProMax,
        android: () => DevicesType.android.samsungGalaxyNote20,
      ),
      child: AdpApp(
        themeMode: ThemeMode.light,
        home: DefaultTabController(
          length: 2,
          child: Builder(builder: (context) {
            return AdaptiveScaffold(
              appBar: AdaptiveAppBar(
                /// elevation: PlatformRuining.isAndroid ? 10.0 : 0.0,
                title: const Text('Adaptive Mobile Preview'),
                bottom: AdaptiveTabBarPreferred(
                  tabs: const [
                    AdaptiveTab(
                      label: Text('star'),
                      icon: AdaptiveIcon(AdpIcons.starFilled),
                    ),
                    AdaptiveTab(
                      label: Text('favorite'),
                      icon: AdaptiveIcon.all(Icons.favorite),
                    ),
                  ],
                ),
                actions: [
                  AdaptiveIconButton(
                    icon: const AdaptiveIcon(AdpIcons.link),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Center(
                child: Text(
                  "-- You're welcome --",
                  style: AdaptiveTypography.of(context)
                      .subheading
                      ?.copyWith(color: AdpColors.blue),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  DialogPresenter.showInformationDialog(
                    context,
                    title: DummyText.generateQuestion,
                    message: DummyText.generateAnswer,
                  );
                },
                child: const AdaptiveIcon(AdpIcons.add),
              ),
              bottomNavigationBar: AdaptiveBottomNavigationBar(
                currentIndex: _currentValue,
                onChanged: (value) => setState(() => _currentValue = value),
                items: const [
                  AdaptiveBottomNavigationBarItem(
                    icon: AdaptiveIcon(AdpIcons.app),
                    label: 'app',
                  ),
                  AdaptiveBottomNavigationBarItem(
                    icon: AdaptiveIcon(AdpIcons.archive),
                    label: 'archive',
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
