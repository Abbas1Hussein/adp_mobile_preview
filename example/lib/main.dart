import 'package:adp_mobile/adp_mobile.dart';
import 'package:adp_mobile_preview/adp_mobile_preview.dart';
import 'package:flutter/material.dart';

void main() {
  DefaultsPlatformManager.initialize(
    targetPlatform: MobileTargetPlatform.iOS,
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
        ios: () => DevicesType.iOS.iPhone13ProMax,
        android: () => DevicesType.android.samsungGalaxyNote20,
      ),
      child: AdpApp(
        home: DefaultTabController(
          length: 2,
          child: AdaptiveScaffold(
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
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Builder(builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  DialogPresenter.showInformationDialog(
                    context,
                    title: DummyText.generateQuestion,
                    message: DummyText.generateAnswer,
                  );
                },
                child: const AdaptiveIcon(AdpIcons.add),
              );
            }),
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
            body: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.network(imageUrls[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static const List<String> imageUrls = [
    'https://i.imgur.com/0NEhC8Y.png',
    'https://i.imgur.com/2KHNJfH.png',
    'https://i.imgur.com/Cx27FXb.png',
  ];
}
