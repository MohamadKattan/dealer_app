import 'package:dealer/components/app_text.dart';
import 'package:dealer/utilities/ui_res_app/ui_responsev_controller.dart';
import 'package:flutter/material.dart';

class AppIndicators {
  static const Widget loadingCircularIndicator = CircularProgressIndicator();
  static const Widget loadingLinearIndicator = LinearProgressIndicator();

  // If you anticipate needing custom indicators:
  static Widget customCircularIndicator({
    double? strokeWidth,
    Color? color,
    BuildContext? context,
  }) {
    final themeColor = context != null ? Theme.of(context).primaryColor : null;
    return CircularProgressIndicator(
      strokeWidth: strokeWidth ?? 4.0,
      valueColor:
          AlwaysStoppedAnimation<Color>(color ?? themeColor ?? Colors.blue),
    );
  }

  static Widget customLinearIndicator({
    double? minHeight,
    Color? color,
  }) {
    return LinearProgressIndicator(
      minHeight: minHeight,
      valueColor: color != null ? AlwaysStoppedAnimation<Color>(color) : null,
    );
  }

  static Widget louding(BuildContext context, {String? txt}) {
    return Container(
      height: UiResponsive.globalMedia(context: context, isHeight: true),
      width: UiResponsive.globalMedia(context: context),
      color: const Color.fromARGB(66, 44, 41, 41),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIndicators.loadingCircularIndicator,
          AppText.normalText(txt ?? 'Please wait...')
        ],
      ),
    );
  }
}
