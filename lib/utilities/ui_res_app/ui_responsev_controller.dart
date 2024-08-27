// this class for control ui screen responsive based on device screen width
import 'package:flutter/material.dart';

enum ScreenSize {
  isMobile(480),
  isIpad(768),
  isLapSmall(1024),
  isDesktop(1200);

  const ScreenSize(this.width);
  final int width;
}

class UiResponsive {
  static double globalMedia({required BuildContext context, bool? isHeight}) {
    final mediaQuery = MediaQuery.of(context).size;
    final width = mediaQuery.width;
    final height = mediaQuery.height;
    if (isHeight ?? false) return height;
    return width;
  }

  static void listingToSizeScreen(ScreenSize width) {
    switch (width) {
      case ScreenSize.isMobile:
        break;
      case ScreenSize.isIpad:
        break;
      case ScreenSize.isLapSmall:
        break;
      case ScreenSize.isDesktop:
        break;
      default:
      // large screen
    }
  }

  static Widget myUiBuilder(BuildContext _, Widget child) {
    return LayoutBuilder(builder: (_, box) {
      final width = box.maxWidth.toInt();

      if (width <= ScreenSize.isMobile.width) {}
      if (width <= ScreenSize.isIpad.width &&
          width > ScreenSize.isMobile.width) {}
      if (width <= ScreenSize.isLapSmall.width &&
          width > ScreenSize.isIpad.width) {}
      if (width <= ScreenSize.isDesktop.width &&
          width > ScreenSize.isLapSmall.width) {}
      if (width > ScreenSize.isDesktop.width) {}
      return child;
    });
  }
}
