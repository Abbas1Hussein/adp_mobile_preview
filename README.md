A simple tool for previewing the mobile app on desktop as an emulator.
This can be useful for developers who want to test their mobile applications on desktop environments,
without needing to run them to actual mobile devices.

| IOS                                           | Android                                       |
| --------------------------------------------- | ----------------------------------------------|
| ![IOS](https://i.imgur.com/uvTFJk1.png)       | ![Android](https://i.imgur.com/bjlWhc0.png)

```dart
AdaptiveMobilePreview(
  type: adaptiveValue(
    ios: () => DevicesType.iOS.iPhone13ProMax,
    android: () => DevicesType.android.samsungGalaxyNote20,
  ),
  child: AdpApp(
    home: YourHomePageWidget(),
  ),
);
```

