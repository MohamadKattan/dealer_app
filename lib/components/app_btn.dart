import 'package:dealer/components/app_text.dart';
import 'package:flutter/material.dart';

class AppBtn {
  static Widget eleBtn(
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
      style:
          ButtonStyle(backgroundColor: WidgetStateProperty.all<Color?>(bgColor)
              // padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              //     EdgeInsets.all(padding ?? 0.0)),
              ),
      child: AppText.normalTxet(txt, fontSize: 18),
    );
  }
}
