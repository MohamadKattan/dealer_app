import 'package:flutter/material.dart';

class AppText {
  static Widget normalTxet(String txt,
      {double? fontSize, double? padding, TextAlign? textAlign}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: Text(
        textAlign: textAlign ?? TextAlign.center,
        txt,
        style: TextStyle(fontSize: fontSize ?? 18),
      ),
    );
  }
}
