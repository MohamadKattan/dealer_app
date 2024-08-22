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
}
