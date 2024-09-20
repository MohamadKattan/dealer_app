import 'package:auto_route/auto_route.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperMethods {
  static void toggelOpenCloseDrawer() {
    final currentState = AppGetter.scaffoldKey.currentState;
    if (currentState == null) return;
    if (!currentState.isDrawerOpen) {
      currentState.openDrawer();
    } else {
      currentState.closeDrawer();
    }
  }

// to achieve local lan of device
  static bool isArabic(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool? lanCode;
    if (currentLocale.languageCode == 'ar') {
      lanCode = true;
    }
    return lanCode ?? false;
  }

  static void getDate() {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime date = DateTime.now();
    AppGetter.dateOFToday = formatter.format(date);
    if (date.hour < 12) {
      AppGetter.isMorning = true;
    }
  }

  static void popMethod(BuildContext context,
      {PageRouteInfo<dynamic>? route, bool rePlace = false}) {
    StackRouter router = context.router;
    if (rePlace && route != null) {
      router.replace(route);
    } else {
      router.maybePop();
    }
  }

  static void pushMethod(
      BuildContext context, PageRouteInfo<dynamic> route, bool replace) {
    StackRouter router = context.router;
    if (replace) {
      router.replace(route);
    } else {
      router.push(route);
    }
  }
}
