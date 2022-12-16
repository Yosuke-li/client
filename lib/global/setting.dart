import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Setting {
  static double tabBarHeight = 50;
  static double tabBarWidth = 60;
  static double tableBottomHeight = 35;

  static double tabBarSecHeight = 28;

  static Future<void> loginSize() async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden, windowButtonVisibility: false);
    await windowManager.setSize(const Size(600, 350));
    await windowManager.setMinimumSize(const Size(600, 350));
    await windowManager.center();
  }

  static Future<void> normalSize() async {
    await windowManager.setTitleBarStyle(TitleBarStyle.normal,
        windowButtonVisibility: true);
    await windowManager.setSize(const Size(1280, 800));
    await windowManager.setMinimumSize(const Size(1280, 800));
    await windowManager.center();
  }

  static bool isVertical = true;

  static Color tabBottomColor = const Color(0xff027DB4);
  static Color tableBarColor = const Color(0xffE5EDF9);
  static Color backGroundColor = const Color(0xffD2E0F4);
  static Color backBorderColor = const Color(0xff8FB6EF);
  static Color tabSelectColor = const Color(0xff8FB6EF);
  static Color orderSubmitColor = const Color(0xffCCE9FF);
  static Color bottomBorderColor = Colors.blue.shade100;
  static Color onSelectColor = Colors.blue.shade50;

  static Color onSubmitColor = const Color(0xff8FB6EF);
  static Color onCancelColor = const Color(0xffD2E0F4);

  /// table的特殊颜色
  static Color tableBlue = const Color(0xff027DB4);
  static Color tableRed = const Color(0xffD9001B);
  static Color tableLightBlue = const Color(0xff02A7F0);
}


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    // When modifying this function, consider modifying the implementation in
    // the base class as well.
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            return child;
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.iOS:
            return child;
        }
    }
  }
}