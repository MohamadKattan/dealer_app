import 'package:flutter/material.dart';

class AppText {
  static Widget normalText(String txt,
      {double? fontSize,
      double? padding,
      TextAlign? textAlign,
      FontWeight? fontWeight}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: Text(
        textAlign: textAlign ?? TextAlign.center,
        txt,
        style: TextStyle(fontSize: fontSize ?? 18, fontWeight: fontWeight),
      ),
    );
  }
}
