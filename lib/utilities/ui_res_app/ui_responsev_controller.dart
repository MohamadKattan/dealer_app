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
      print(width);
      if (width <= ScreenSize.isMobile.width) {
        print('MMMMMMMM');
      }
      if (width <= ScreenSize.isIpad.width &&
          width > ScreenSize.isMobile.width) {
        print('tabbbb');
      }
      if (width <= ScreenSize.isLapSmall.width &&
          width > ScreenSize.isIpad.width) {
        print('lappppppp');
      }
      if (width <= ScreenSize.isDesktop.width &&
          width > ScreenSize.isLapSmall.width) {
        print('desktop');
      }
      if (width > ScreenSize.isDesktop.width) {
        print('large screen');
      }
      return child;
    });
  }
}
