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
}
