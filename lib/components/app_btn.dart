import 'package:dealer/components/app_indicators.dart';
import 'package:dealer/components/app_text.dart';
import 'package:flutter/material.dart';

class AppBtn {
  static Widget elevBtn(
      {required String txt,
      required void Function()? onPressed,
      Function()? onLongPress,
      void Function(bool)? onHover,
      double? padding,
      Color? bgColor}) {
    return ElevatedButton(
      onPressed: onPressed,
      onHover: onHover,
      onLongPress: onLongPress,
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color?>(bgColor)),
      child: AppText.normalTxet(txt, fontSize: 18),
    );
  }

  static Widget loudingBtn({Color? bgColor}) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color?>(bgColor)),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: AppIndicators.loadingCircularIndicator,
        ));
  }
}
